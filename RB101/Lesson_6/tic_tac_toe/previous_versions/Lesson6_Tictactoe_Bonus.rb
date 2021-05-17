WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

player_score = 0
computer_score = 0

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
    prompt "Choose a square (#{joinor(empty_squares(brd), punct = ", ", word = 'or')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def ai_strategy(marker, brd)
  WINNING_LINES.select { |line| brd.values_at(*line).count(marker) == 2 && brd.values_at(*line).any?(INITIAL_MARKER) }
end

def ai_find_squares(marker, brd)
  ai_strategy(marker,brd).flatten.select { |squares| brd[squares] == INITIAL_MARKER }
end

def computer_turn!(brd)
  sleep(1)
  square = nil

  if ai_strategy(COMPUTER_MARKER, brd).any? #offense
    square = ai_find_squares(COMPUTER_MARKER, brd).sample 
  elsif ai_strategy(PLAYER_MARKER, brd).any? #defense
    square = ai_find_squares(PLAYER_MARKER, brd).sample
  elsif brd[5] == ' '
    square = 5
  else
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
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
  puts p_score > c_score ? "Player is the match winner!" : "Computer is the match winner!"
end

def alternate_player!(players)
  players.reverse!
end

def place_piece!(players)
  players.first.call
end

def who_goes_first?(player_moves)
  loop do
    prompt "Who decides who goes first? (Player or Computer)"
    decide_first = gets.chomp

    if decide_first.downcase == 'computer'
       return player_moves.shuffle
    elsif decide_first.downcase == 'player'
      prompt "Who should go first? (Player or Computer)"
      goes_first = gets.chomp

      if goes_first.downcase == 'player'
        return player_moves
      elsif goes_first.downcase == 'computer'
        return player_moves.reverse
      else
        prompt "Please enter a valid response: 'Player' or 'Computer'"
      end
    else
      prompt "Please enter a valid response: 'Player' or 'Computer'"
    end
  end
end

loop do
  board = initialize_board
  who_goes_first = [Proc.new { player_turn!(board) }, Proc.new { computer_turn!(board) }] 

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
    detect_winner(board) == 'Player' ? player_score += 1 : computer_score += 1
  else
    prompt "It's a tie!"
  end

  display_score(player_score, computer_score)
  
  break if player_score == 2 || computer_score == 2

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end


display_match_winner(player_score, computer_score) if player_score == 2 || computer_score == 2
prompt "Thanks for playing Tic Tac Toe! Good bye!"
