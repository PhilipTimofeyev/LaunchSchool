INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  system 'clear'
  prompt "Hello and welcome to Tic-Tac_Toe!"
  prompt "The goal is to get your marker to fill an entire row, column, or diagonally"
  prompt "What size should the board be?
    Enter '9' for 3x3, '16' for 4x4, or '25' for 5x5."
  board_size = nil
  loop do
    board_size = gets.chomp.to_i
    break if [9, 16, 25].include?(board_size)
    prompt "Please enter a valid response of either '9'. '16', or '25'"
  end
  board_size
end

def number_of_rounds
  prompt "How many rounds would you like to play per match?"
  rounds = nil
  loop do
    rounds = gets.chomp.to_i
    return rounds if rounds.positive?
    prompt "Please enter a positive integer"
  end
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

def display_board_3x3(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def display_board_4x4(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  |  #{brd[4]}"
  puts "     |     |     |"
  puts "-----+-----+-----+-----"
  puts "     |     |     |"
  puts "  #{brd[5]}  |  #{brd[6]}  |  #{brd[7]}  |  #{brd[8]}"
  puts "     |     |     |"
  puts "-----+-----+-----+-----"
  puts "     |     |     |"
  puts "  #{brd[9]}  |  #{brd[10]}  |  #{brd[11]}  |  #{brd[12]}"
  puts "     |     |     |"
  puts "-----+-----+-----+-----"
  puts "     |     |     |"
  puts "  #{brd[13]}  |  #{brd[14]}  |  #{brd[15]}  |  #{brd[16]}"
  puts "     |     |     |"
  puts ""
end

def display_board_5x5(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  |  #{brd[4]}  |  #{brd[5]}  "
  puts "     |     |     |     |     "
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |     "
  puts "  #{brd[6]}  |  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  |  #{brd[10]}  "
  puts "     |     |     |     |     "
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |     "
  puts "  #{brd[11]}  |  #{brd[12]}  |  #{brd[13]}  |  #{brd[14]}  |  #{brd[15]}  "
  puts "     |     |     |     |     "
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |     "
  puts "  #{brd[16]}  |  #{brd[17]}  |  #{brd[18]}  |  #{brd[19]}  |  #{brd[20]}  "
  puts "     |     |     |     |     "
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |     "
  puts "  #{brd[21]}  |  #{brd[22]}  |  #{brd[23]}  |  #{brd[24]}  |  #{brd[25]}  "
  puts "     |     |     |     |     "
  puts ""
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

def display_board(brd)
  case brd.size
  when 9
    display_board_3x3(brd)
  when 16
    display_board_4x4(brd)
  when 25
    display_board_5x5(brd)
  end
end

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
  columns = []

  (1..brd_size).each_slice(board_length) { |square| rows << square }
  board_length.times { columns << rows.map(&:shift) }

  columns
end

def winning_diagonals(brd_size)
  board_length = Math.sqrt(brd_size).to_i
  across_slice = board_length + 1
  diag_slice_rotation = board_length - 1

  diag_right = []
  diag_left = []

  diag_right << (1..brd_size).to_a.each_slice(across_slice).map(&:first)
  diag_left << (1..brd_size).to_a.rotate(diag_slice_rotation).each_slice(diag_slice_rotation).map(&:first)[0...-2]

  diag_right + diag_left
end

def winning_arr(brd_size)
  winning_rows(brd_size) +
    winning_columns(brd_size) +
    winning_diagonals(brd_size)
end

# Player move

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

def ai_turn!(brd, win_lines)
  unless enough_moves_made_for_a_win?(brd)
    computer_turn!(brd, win_lines)
  else
    best_score = -Float::INFINITY
    best_move = nil
    empty_squares(brd).each do |square|
      brd[square] = COMPUTER_MARKER
      score = minimax(brd, 0, -Float::INFINITY, Float::INFINITY, false, win_lines)
      brd[square] = ' '
      if score > best_score
        best_score = score
        best_move = square
      end
    end
    brd[best_move] = COMPUTER_MARKER
  end
end

# Normal AI Moveset

def ai_strategy(marker, brd, win_lines)
  win_lines.select do |line|
    brd.values_at(*line).count(marker) == (Math.sqrt(brd.size) - 1) && brd.values_at(*line).any?(INITIAL_MARKER)
  end
end

def ai_find_squares(marker, brd, win_lines)
  ai_strategy(marker, brd, win_lines).flatten.select do |squares|
    brd[squares] == INITIAL_MARKER
  end
end

def computer_turn!(brd, win_lines)
  square = if ai_strategy(COMPUTER_MARKER, brd, win_lines).any? # offense
             ai_find_squares(COMPUTER_MARKER, brd, win_lines).sample
           elsif ai_strategy(PLAYER_MARKER, brd, win_lines).any? # defense
             ai_find_squares(PLAYER_MARKER, brd, win_lines).sample
           elsif brd[5] == ' '
             5
           else
             empty_squares(brd).sample
           end

  brd[square] = COMPUTER_MARKER
end

# Minimax with Pruning AI Moveset

def minimax(brd, depth, alpha, beta, is_maximizing, win_lines)
  scores = {
    'Player' => -1,
    'Computer' => 1,
    'Tie' => 0
  }

  result = minimax_winner(brd, win_lines)
  if !result.nil?
    scores[result]
  elsif is_maximizing
    p maximizing(brd, depth, alpha, beta, win_lines)
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

def minimax_winner(brd, win_lines)
  win_lines.each do |line|
    if brd.values_at(*line).all?('X')
      return 'Player'
    elsif brd.values_at(*line).all?('O')
      return 'Computer'
    elsif board_full?(brd)
      return 'Tie'
    end
  end
  nil
end

def place_piece!(players)
  players.first.call
end

def alternate_player!(players)
  players.reverse!
end

# When to use on MinMax
def enough_moves_made_for_a_win?(brd)
  if brd.size == 9
    true
  elsif brd.size == 16
    used_squares(brd).size > ((Math.sqrt(brd.size) * 2) - 1)
  elsif brd.size == 25
    used_squares(brd).size > 13
  end
end

def detect_winner(brd, win_lines)
  win_lines.each do |line|
    if brd.values_at(*line).all?('X')
      return 'Player'
    elsif brd.values_at(*line).all?('O')
      return 'Computer'
    end
  end
  nil
end

def someone_won?(brd, win_lines)
  !!detect_winner(brd, win_lines)
end

def display_score(p_score, c_score)
  prompt "Player Score: #{p_score}, Computer Score: #{c_score}"
end

def display_match_winner(p_score, c_score)
  if p_score > c_score
    puts "Player is the match winner!"
  else
    puts "Computer is the match winner!"
  end
end

# Game Loop
loop do
  board_size = welcome
  rounds = number_of_rounds
  winning_lines = winning_arr(board_size)

  scores = { player: 0, computer: 0 }

  loop do
    board = initialize_board(board_size)
    players = [Proc.new { player_turn!(board) },
               Proc.new { ai_turn!(board, winning_lines) }]

    current_player = who_decides_who_goes_first?(players)

    loop do
      display_board(board)
      place_piece!(current_player)
      alternate_player!(current_player)
      break if someone_won?(board, winning_lines) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board, winning_lines)
      prompt "#{detect_winner(board, winning_lines)} won!"
      if detect_winner(board, winning_lines) == 'Player'
        scores[:player] += 1
      else
        scores[:computer] += 1
      end
    else
      prompt "It's a tie!"
    end

    display_score(scores[:player], scores[:computer])

    break if scores[:player] == rounds || scores[:computer] == rounds

    prompt "Continue to next round? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end

  if scores[:player] == rounds || scores[:computer] == rounds
    display_match_winner(scores[:player], scores[:computer])
  end

  prompt "Would you like to play again? (y or n)"
  another_match = gets.chomp.downcase

  break if another_match.start_with?('n')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
