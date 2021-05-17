WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

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
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def computer_turn!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def ai_move(brd)
  best_score = -Float::INFINITY
  best_move = nil
  brd.each do |k, v|
    if v == ' '
      brd[k] = COMPUTER_MARKER
      score = minimax(brd, 0, false)
      brd[k] = ' '
      if score > best_score
        best_score = score
        best_move = k
      end
    end
  end
  brd[best_move] = COMPUTER_MARKER
end

def minimax(brd, depth, is_maximizing)
  scores = {
    'Player' => -1,
    'Computer' => 1,
    'Tie' => 0
  }

  result = detect_winner(brd)
  if result != nil
    score = scores[result]
    return score
  end
  
  if is_maximizing
    best_score = -Float::INFINITY
    brd.each do |k, v|
      if v == ' '
        brd[k] = COMPUTER_MARKER
        score = minimax(brd, depth + 1, false)
        brd[k] = ' '
        best_score = [score, best_score].max
      end
    end
    best_score
    return best_score
  else
    best_score = Float::INFINITY
    brd.each do |k, v|
      if v == ' '
        brd[k] = PLAYER_MARKER
        score = minimax(brd, depth + 1, true)
        brd[k] = ' '
        best_score = [score, best_score].min
      end
    end
    return best_score
  end
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
    elsif brd.values_at(line[0], line[1], line[2]).all?('O')
      return 'Computer'
    elsif board_full?(brd)
      return 'Tie'
    end
  end
  nil
end

loop do
  board = initialize_board
  loop do

    display_board(board)

    player_turn!(board)
    break if someone_won?(board) || board_full?(board)

    
    ai_move(board)
    break if someone_won?(board) || board_full?(board)

  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
