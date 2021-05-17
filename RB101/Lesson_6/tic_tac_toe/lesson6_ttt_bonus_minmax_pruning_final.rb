INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def clear_screen
  Gem.win_platform? ? (system "cls") : (system "clear")
end

def integer?(input)
  /^-?\d+$/.match(input)
end

def welcome
  clear_screen
  prompt "Hello and welcome to Tic-Tac_Toe!"
  puts ""
  prompt "The goal is to get your marker to fill an entire
  row, column, or line diagonally."
  puts ""
  prompt "The person with the highest score at the end of the match, wins!"
  puts ""
end

def what_board_size?
  prompt "What size should the board be?"
  prompt "Enter '3' for 3x3, '4' for 4x4, or '5' for 5x5, ect."
  board_size = nil
  loop do
    board_size = gets.chomp
    break if integer?(board_size) && board_size.to_i > 2
    prompt "Please enter an integer of at least 3."
  end
  board_size.to_i**2
end

def number_of_rounds
  prompt "How many rounds would you like to play per match?"
  rounds = nil
  loop do
    rounds = gets.chomp
    break if rounds.to_i.positive? && integer?(rounds)
    prompt "Please enter a positive integer"
  end
  rounds.to_i
end

def who_goes_first?(player_moves)
  prompt "Who should go first? (Player or Computer)"
  loop do
    goes_first = gets.chomp
    case goes_first.downcase
    when 'player'
      return player_moves
    when 'computer'
      return player_moves.reverse
    else
      prompt "Please enter a valid response: 'Player' or 'Computer'"
    end
  end
end

def who_decides_who_goes_first?(player_moves)
  loop do
    prompt "Who should decide who goes first? (Player or Computer)"
    decide_first = gets.chomp

    case decide_first.downcase
    when 'computer'
      return player_moves.shuffle
    when 'player'
      return who_goes_first?(player_moves)
    else
      prompt "Please enter a valid response: 'Player' or 'Computer'"
    end
  end
end

def initialize_board(brd_size)
  new_board = {}
  (1..brd_size).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

def display_board(brd, brd_size)
  clear_screen
  prompt "You are an #{PLAYER_MARKER}. Computer is an #{COMPUTER_MARKER}"

  root = Math.sqrt(brd_size)
  row_multiple = root - 2
  output = ''

  brd.each do |k, _v|
    if k % root > 0
      output <<  "|-------+#{('-------+' * row_multiple)}-------|\n" unless k > 1
      output <<  "|       |#{('       |' * row_multiple)}       |\n" unless k > 1
      output << "|   #{brd[k]}   "
    elsif k % root == 0
      output << "|   #{brd[k]}   |\n"
      output << "|       |#{('       |' * row_multiple)}       |\n"
      output << "|-------+#{('-------+' * row_multiple)}-------|\n"
      output << "|       |#{('       |' * row_multiple)}       |\n" unless k == brd_size
    end
  end
  puts output
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

def joinor(open_squares, delimiter=', ', word='or')
  case open_squares.size
  when 0 then ''
  when 1 then open_squares.first
  when 2 then open_squares.join(" #{word} ")
  else
    open_squares[-1] = "#{word} #{open_squares.last}"
    open_squares.join(delimiter)
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def used_squares(brd)
  brd.keys.select { |num| brd[num] != INITIAL_MARKER }
end

def board_full?(brd)
  empty_squares(brd).empty?
end

# Find all winning movesets

def winning_rows(brd_size)
  board_length = Math.sqrt(brd_size).to_i
  rows = []

  (1..brd_size).each_slice(board_length) { |square| rows << square }
  rows
end

def winning_columns(brd_size)
  board_length = Math.sqrt(brd_size).to_i
  rows = []

  (1..brd_size).each_slice(board_length) { |square| rows << square }

  rows.transpose
end

def winning_diagonals(brd_size)
  board_length = Math.sqrt(brd_size).to_i
  across_slice = board_length + 1
  diag_rot = board_length - 1

  diag_right = []
  diag_left = []

  diag_right << (1..brd_size).to_a.each_slice(across_slice).map(&:first)
  diag_left << (1..brd_size).to_a.rotate(diag_rot).each_slice(diag_rot)
                            .map(&:first)[0...-2]

  diag_right + diag_left
end

def winning_arr(brd_size)
  winning_rows(brd_size) +
    winning_columns(brd_size) +
    winning_diagonals(brd_size)
end

# Player Move

def player_turn!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

# Computer Move

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def ai_turn!(brd, win_lines)
  if when_to_minimax?(brd)
    prompt "AI is thinking..."
    best_score = -Float::INFINITY
    best_move = nil
    empty_squares(brd).each do |square|
      brd[square] = COMPUTER_MARKER
      score = minimax(brd, 0, -Float::INFINITY, Float::INFINITY, false,
                      win_lines)
      brd[square] = ' '
      if score > best_score
        best_score = score
        best_move = square
      end
    end
    sleep(1)
    brd[best_move] = COMPUTER_MARKER
  else computer_turn!(brd, win_lines)
  end
end

# Normal AI Moveset

def ai_strategy(marker, brd, win_lines)
  win_lines.select do |line|
    brd.values_at(*line).count(marker) == (Math.sqrt(brd.size) - 1) &&
      brd.values_at(*line).any?(INITIAL_MARKER)
  end
end

def ai_find_squares(marker, brd, win_lines)
  ai_strategy(marker, brd, win_lines).flatten.select do |squares|
    brd[squares] == INITIAL_MARKER
  end
end

def computer_turn!(brd, win_lines)
  square = if ai_strategy(COMPUTER_MARKER, brd, win_lines).any?       # offense
             ai_find_squares(COMPUTER_MARKER, brd, win_lines).sample
           elsif ai_strategy(PLAYER_MARKER, brd, win_lines).any?      # defense
             ai_find_squares(PLAYER_MARKER, brd, win_lines).sample
           elsif brd.size.odd? && brd[(brd.size / 2) + 1] == ' '
             (brd.size / 2) + 1                                       # center
           else
             empty_squares(brd).sample
           end

  brd[square] = COMPUTER_MARKER
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

# Minimax with Pruning AI Moveset

def minimax(brd, depth, alpha, beta, is_maximizing, win_lines)
  if detect_winner(brd, win_lines) || depth >= 5
    return minimax_score(brd, win_lines, depth)
  end

  if is_maximizing
    maximizing(brd, depth, alpha, beta, win_lines)
  else
    minimizing(brd, depth, alpha, beta, win_lines)
  end
end

def maximizing(brd, depth, alpha, beta, win_lines)
  best_score = -Float::INFINITY
  empty_squares(brd).each do |square|
    brd[square] = COMPUTER_MARKER
    score = minimax(brd, depth + 1, alpha, beta, false, win_lines)
    brd[square] = ' '
    best_score = [score, best_score].max
    alpha = [alpha, score].max
    break if beta <= alpha
  end
  best_score
end

def minimizing(brd, depth, alpha, beta, win_lines)
  best_score = Float::INFINITY
  empty_squares(brd).each do |square|
    brd[square] = PLAYER_MARKER
    score = minimax(brd, depth + 1, alpha, beta, true, win_lines)
    brd[square] = ' '
    best_score = [score, best_score].min
    beta = [beta, score].min
    break if beta <= alpha
  end
  best_score
end

# When to use on MinMax

def when_to_minimax?(brd)
  empty_squares(brd).size < 12
end

def minimax_score(brd, win_lines, depth)
  case detect_winner(brd, win_lines)
  when 'Computer'
    10 - depth
  when 'Player'
    depth - 10
  else
    0
  end
end

def place_piece!(players)
  players.first.call
end

def alternate_player!(players)
  players.reverse!
end

def detect_winner(brd, win_lines)
  winner = nil
  win_lines.each do |line|
    if brd.values_at(*line).all?('X')
      winner = 'Player'
    elsif brd.values_at(*line).all?('O')
      winner = 'Computer'
    end
  end
  if board_full?(brd) && winner.nil?
    winner = 'Tie'
  end
  winner
end

def display_score(p_score, c_score)
  prompt "Player Score: #{p_score}, Computer Score: #{c_score}"
end

def display_win_update_score(brd, win_lines, scores)
  if detect_winner(brd, win_lines) == 'Tie'
    prompt "It's a tie!"
  else
    prompt "#{detect_winner(brd, win_lines)} wins!"
    scores[detect_winner(brd, win_lines).to_sym] += 1
  end
  display_score(scores[:Player], scores[:Computer])
end

def detect_match_winner(score, round)
  score[:Player] == round || score[:Computer] == round
end

def display_match_winner(p_score, c_score)
  if p_score > c_score
    prompt "Player is the match winner!"
  else
    prompt "Computer is the match winner!"
  end
end

# Game Loop

loop do
  welcome
  board_size = what_board_size?
  rounds = number_of_rounds
  winning_lines = winning_arr(board_size)

  scores = { Player: 0, Computer: 0 }

  loop do
    board = initialize_board(board_size)
    players = [Proc.new { player_turn!(board) },
               Proc.new { ai_turn!(board, winning_lines) }]

    current_player = who_decides_who_goes_first?(players)

    loop do
      display_board(board, board_size)
      place_piece!(current_player)
      alternate_player!(current_player)
      break if !detect_winner(board, winning_lines).nil?
    end

    display_board(board, board_size)

    display_win_update_score(board, winning_lines, scores)

    break if detect_match_winner(scores, rounds)

    prompt "Continue to next round? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end

  if detect_match_winner(scores, rounds)
    display_match_winner(scores[:Player], scores[:Computer])
  end

  prompt "Would you like to play again? (y or n)"
  another_match = gets.chomp.downcase

  break unless another_match.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
