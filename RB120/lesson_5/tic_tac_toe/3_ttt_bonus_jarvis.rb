class Board
  attr_reader :squares
  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def size
    squares.size
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
    winning_lines(9).each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def winning_lines(brd_size)
    winning_rows(brd_size) +
      winning_columns(brd_size) +
      winning_diagonals(brd_size)
  end

  private

  def winning_rows(brd_size)
    board_length = Math.sqrt(brd_size).to_i
    rows = []

    (1..brd_size).each_slice(board_length) { |square| rows << square }
    rows
  end

  def winning_columns(brd_size)
    winning_rows(brd_size).transpose
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

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
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
    @marker = choose_marker
  end

  def move(board)
    puts "Choose a square between (#{board.unmarked_keys.join(', ')}): "
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
end

class Computer
  OPPONENTS = ['(1) Wall-E (Easy)', '(2) Jarvis Medium', 'Hard']

  attr_reader :marker

  attr_accessor :opponent
  attr_reader :name

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
      break if [1, 2, 3].include? (choice)
      puts "Sorry, that's not a valid choice."
    end
    choice
  end

  def select_opponent
    case ask_which_opponent
    when 1 then WALL_E.new
    when 2 then JARVIS.new
    end
  end
end

class WALL_E < Computer
  def initialize
    @name = "WALL-E"
    @marker = 'W'
  end

  def move(board, need_human = nil)
    board[board.unmarked_keys.sample] = marker
  end
end

class JARVIS < Computer
  def initialize
    @name = "J.A.R.V.I.S"
    @marker = 'J'
  end

  def find_winning_lines(marker, brd)
    win_lines = brd.winning_lines(brd.size)
    win_lines.select do |line|
      squares = brd.squares.values_at(*line).collect(&:marker)
      squares.count(marker) == (Math.sqrt(brd.size) - 1) && squares.any?(Square::INITIAL_MARKER)
    end
  end

  def find_winning_squares(marker, brd)
    find_winning_lines(marker, brd).flatten.select do |line|
      brd.squares[line].marker == Square::INITIAL_MARKER
    end
  end

  def determine_strategic_move(marker, brd)
    if find_winning_lines(marker, brd).any?
      find_winning_squares(marker, brd).sample
    end
  end

  def determine_center_square(brd)
    if brd.size.odd? && brd.squares[(brd.size / 2) + 1].marker == Square::INITIAL_MARKER
      (brd.size / 2) + 1
    end
  end

  def computer_turn(board, human)
    square = nil

    loop do
      square = determine_strategic_move(marker, board)
      break if !square.nil?
      square = determine_strategic_move(human.marker, board)
      break if !square.nil?
      square = determine_center_square(board)
      break if !square.nil?
      square = board.unmarked_keys.sample
      break if !square.nil?
    end
    square
  end

  def move(board, human)
    best_square = computer_turn(board, human)
    board[best_square] = marker
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_marker = human
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're an #{human.marker} and computer is an #{computer.marker}."
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
