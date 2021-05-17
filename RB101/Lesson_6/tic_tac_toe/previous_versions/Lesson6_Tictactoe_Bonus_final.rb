WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
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

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

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

def ai_move!(brd)
  best_score = -Float::INFINITY
  best_move = nil
  empty_squares(brd).each do |square|
    brd[square] = COMPUTER_MARKER
    score = minimax(brd, 0, -Float::INFINITY, Float::INFINITY, false)
    brd[square] = ' '
    if score > best_score
      best_score = score
      best_move = square
    end
  end
  brd[best_move] = COMPUTER_MARKER
end

def minimax(brd, depth, alpha, beta, is_maximizing)
  scores = {
    'Player' => -1,
    'Computer' => 1,
    'Tie' => 0
  }

  result = minimax_winner(brd)
  if !result.nil?
    scores[result]
  elsif is_maximizing
    maximizing(brd, depth, alpha, beta)
  else
    minimizing(brd, depth, alpha, beta)
  end
end

def maximizing(brd, depth, alpha, beta)
  best_score = -Float::INFINITY
  empty_squares(brd).each do |square|
    brd[square] = COMPUTER_MARKER
    score = minimax(brd, depth + 1, alpha, beta, false)
    brd[square] = ' '
    best_score = [score, best_score].max
    alpha = [alpha, score].max
    break if beta <= alpha
  end
  best_score
end

def minimizing(brd, depth, alpha, beta)
  best_score = Float::INFINITY
  empty_squares(brd).each do |square|
    brd[square] = PLAYER_MARKER
    score = minimax(brd, depth + 1, alpha, beta, true)
    brd[square] = ' '
    best_score = [score, best_score].min
    beta = [beta, score].min
    break if beta <= alpha
  end
  best_score
end

def minimax_winner(brd)
  WINNING_LINES.each do |line|
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

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).all?('X')
      return 'Player'
    elsif brd.values_at(*line).all?('O')
      return 'Computer'
    end
  end
  nil
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

def alternate_player!(players)
  players.reverse!
end

def place_piece!(players)
  players.first.call
end

def who_goes_first?(player_moves)
  loop do
    prompt "Who should decide who goes first? (Player or Computer)"
    decide_first = gets.chomp

    case decide_first.downcase
    when 'computer'
      return player_moves.shuffle
    when 'player'
      prompt "Who should go first? (Player or Computer)"
      goes_first = gets.chomp
      case goes_first.downcase
      when 'player'
        return player_moves
      when 'computer'
        return player_moves.reverse
      else
        prompt "Please enter a valid response: 'Player' or 'Computer'"
      end
    else
      prompt "Please enter a valid response: 'Player' or 'Computer'"
    end
  end
end

system 'clear' 
prompt "Hello and welcome to Tic-Tac_Toe!" 
scores = { player: 0, computer: 0 }

loop do
  board = initialize_board
  who_goes_first = [Proc.new { player_turn!(board) },
                    Proc.new { ai_move!(board) }]

  current_player = who_goes_first?(who_goes_first)

  loop do
    display_board(board)
    place_piece!(current_player)
    alternate_player!(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    if detect_winner(board) == 'Player'
      scores[:player] += 1
    else
      scores[:computer] += 1
    end
  else
    prompt "It's a tie!"
  end

  display_score(scores[:player], scores[:computer])

  break if scores[:player] == 2 || scores[:computer] == 2

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

if scores[:player] == 2 || scores[:computer] == 2
  display_match_winner(scores[:player], scores[:computer])
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
