class Board
  attr_reader :squares, :board_size

  def initialize
    @board_size = prompt_what_size
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

  def draw
    root = Math.sqrt(board_size)
    row_multiple = root - 2
    output = ''

    squares.each do |k, _v|
      if k % root > 0
        output <<  "|-------+#{('-------+' * row_multiple)}-------|\n" unless k > 1
        output <<  "|       |#{('       |' * row_multiple)}       |\n" unless k > 1
        output << "|  #{squares[k]}   "
      elsif k % root == 0
        output << "|  #{squares[k]}   |\n"
        output << "|       |#{('       |' * row_multiple)}       |\n"
        output << "|-------+#{('-------+' * row_multiple)}-------|\n"
        output << "|       |#{('       |' * row_multiple)}       |\n" unless k == board_size
      end
    end
    puts output
  end

  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

  def size
    squares.size
  end

  def prompt_what_size
    puts "Please enter a board size of either: 3, 4, or 5."
    answer = nil
    loop do
      answer = gets.chomp.to_i**2
      break if [9, 16, 25].include?(answer)
      puts "Sorry, that's not a valid choice."
    end
    answer
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    winning_lines.each do |line|
      squares = @squares.values_at(*line)
      if identical_marker_line?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..board_size).each { |key| squares[key] = Square.new }
    Square.reset
  end

  def winning_lines
    winning_rows +
      winning_columns +
      winning_diagonals
  end

  private

  def winning_rows
    board_length = Math.sqrt(board_size).to_i
    rows = []

    (1..board_size).each_slice(board_length) { |square| rows << square }
    rows
  end

  def winning_columns
    winning_rows.transpose
  end

  def winning_diagonals
    board_length = Math.sqrt(board_size).to_i
    across_slice = board_length + 1
    diag_rot = board_length - 1

    diag_right = []
    diag_left = []

    diag_right << (1..board_size).to_a.each_slice(across_slice).map(&:first)
    diag_left << (1..board_size).to_a.rotate(diag_rot).each_slice(diag_rot)
                              .map(&:first)[0...-2]

    diag_right + diag_left
  end

  def identical_marker_line?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != Math.sqrt(board_size).to_i
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = ' '

  @@square_num = 1

  attr_accessor :marker
  attr_reader :num

  def initialize
    @marker = INITIAL_MARKER
    @num = convert_to_two_chars
    @@square_num += 1
  end

  def convert_to_two_chars
    @@square_num < 10 ? " #{@@square_num}" : @@square_num.to_s
  end

  def to_s
    marker == INITIAL_MARKER ? num : marker
  end

  def self.reset
    @@square_num = 1
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Human
  attr_reader :marker

  def initialize
    @marker = ' ' + choose_marker
  end

  def move(board)
    puts "Choose a square between (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = marker
  end

  def choose_marker
    puts "Enter any single character to set your marker:"
    mark = nil
    loop do
      mark = gets.chomp.strip
      break if mark.length == 1
      puts "Sorry, that's not a valid choice."
    end
    mark
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
end

class Computer
  OPPONENTS = ['(1) Wall-E (Easy)', '(2) Jarvis Medium', 'Hard']

  attr_accessor :opponent
  attr_reader :name, :marker

  def initialize
    @opponent = select_opponent
    @name = opponent.name
    @marker = opponent.marker
  end

  def move(board, need_human = nil)
    opponent.move(board, need_human)
  end

  private

  def ask_which_opponent
    puts "Please select an opponent: #{OPPONENTS.join(', ')}"
    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if [1, 2, 3].include? choice
      puts "Sorry, that's not a valid choice."
    end
    choice
  end

  def select_opponent
    case ask_which_opponent
    when 1 then WallE.new
    when 2 then Jarvis.new
    when 3 then ExMachina.new
    end
  end
end

class WallE < Computer
  def initialize
    @name = "WALL-E"
    @marker = ' W'
  end

  def move(board, need_human = nil)
    board[board.unmarked_keys.sample] = marker
  end
end

class Jarvis < Computer
  def initialize
    @name = "J.A.R.V.I.S"
    @marker = ' J'
  end

  def find_winning_lines(marker, brd)
    brd.winning_lines.select do |line|
      squares = brd.squares.values_at(*line).collect(&:marker)
      squares.count(marker) == (Math.sqrt(brd.size) - 1) &&
        squares.any?(Square::INITIAL_MARKER)
    end
  end

  def find_winning_squares(marker, brd)
    find_winning_lines(marker, brd).flatten.select do |line|
      brd.squares[line].marker == Square::INITIAL_MARKER
    end
  end

  def determine_strategic_move(marker, brd)
    return unless find_winning_lines(marker, brd).any?
    find_winning_squares(marker, brd).sample
  end

  def determine_center_square(brd)
    return unless brd.size.odd? &&
                  brd.squares[(brd.size / 2) + 1].marker ==
                  Square::INITIAL_MARKER
    (brd.size / 2) + 1
  end

  def computer_turn(board, human)
    square = nil

    offense = determine_strategic_move(marker, board)
    defense = determine_strategic_move(human.marker, board)
    center = determine_center_square(board)
    random = board.unmarked_keys.sample

    square = [offense, defense, center, random].compact.first
  end

  def move(board, human)
    best_square = computer_turn(board, human)
    board[best_square] = marker
  end
end

class ExMachina < Computer
  def initialize
    @name = "Ex Machina"
    @marker = ' E'
  end

  def move(brd, human)
    best_score = -Float::INFINITY
    best_move = nil
    brd.unmarked_keys.each do |key|
      brd[key] = marker
      score = minimax(brd, 0, -Float::INFINITY, Float::INFINITY, false, brd.winning_lines, human)
      brd[key] = ' '
      if score > best_score
        best_score = score
        best_move = key
      end
    end
    brd[best_move] = marker
  end

  def minimax(brd, depth, alpha, beta, is_maximizing, win_lines, human)
    scores = {
      'Player' => -1,
      'Computer' => 1,
      'Tie' => 0
    }

    result = minimax_winner(brd, human)
    if !result.nil?
      scores[result]
    elsif is_maximizing
      maximizing(brd, depth, alpha, beta, win_lines, human)
    else
      minimizing(brd, depth, alpha, beta, win_lines, human)
    end
  end

  def minimax_winner(brd, human)
    case brd.winning_marker
    when human.marker
      return 'Player'
    when marker
      return 'Computer'
    else
      return 'Tie' if brd.full?
    end
    nil
  end

  def maximizing(brd, depth, alpha, beta, win_lines, human)
    best_score = -Float::INFINITY
    brd.unmarked_keys.each do |key|
      brd[key] = marker
      score = minimax(brd, depth + 1, alpha, beta, false, win_lines, human)
      brd[key] = Square::INITIAL_MARKER
      best_score = [score, best_score].max
      alpha = [alpha, score].max
      break if beta <= alpha
    end
    best_score
  end

  def minimizing(brd, depth, alpha, beta, win_lines, human)
    best_score = Float::INFINITY
    brd.unmarked_keys.each do |key|
      brd[key] = human.marker
      score = minimax(brd, depth + 1, alpha, beta, true, win_lines, human)
      brd[key] = ' '
      best_score = [score, best_score].min
      beta = [beta, score].min
      break if beta <= alpha
    end
    best_score
  end
end


class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    display_welcome_message
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = human
  end

  def play
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a#{human.marker} and computer is a#{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    human.move(board)
  end

  def human_turn?
    @current_marker == human
  end

  def computer_moves
    computer.move(board, human)
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer
    else
      computer_moves
      @current_marker = human
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "The board is full!"
      puts computer.marker
    end
  end

  def play_again?
    answer = ''

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y nor n."
    end

    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = human
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def main_game
    loop do
      clear
      display_board
      player_move
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
  end
end

game = TTTGame.new
game.play
