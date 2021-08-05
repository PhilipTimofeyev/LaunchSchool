require 'io/console'

module AuxMethods
  def prompt(msg)
    puts "\n=> #{msg}"
  end

  def clear_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def begin_io
    prompt "Press any key to begin."
    $stdin.getch
    clear_screen
  end

  def next_round_io
    prompt "Press any key to start next round #{round}."
    $stdin.getch
    clear_screen
  end
end

class Rock
  attr_reader :name

  def initialize
    @name = 'rock'
  end

  def >(other_move)
    other_move.class == Scissors || other_move.class == Lizard
  end

  def <(other_move)
    other_move.class == Paper || other_move.class == Spock
  end
end

class Paper
  attr_reader :name

  def initialize
    @name = 'paper'
  end

  def >(other_move)
    other_move.class == Rock || other_move.class == Spock
  end

  def <(other_move)
    other_move.class == Scissors || other_move.class == Lizard
  end
end

class Scissors
  attr_reader :name

  def initialize
    @name = 'scissors'
  end

  def >(other_move)
    other_move.class == Paper || other_move.class == Lizard
  end

  def <(other_move)
    other_move.class == Rock || other_move.class == Spock
  end
end

class Spock
  attr_reader :name

  def initialize
    @name = 'spock'
  end

  def >(other_move)
    other_move.class == Scissors || other_move.class == Rock
  end

  def <(other_move)
    other_move.class == Paper || other_move.class == Lizard
  end
end

class Lizard
  attr_reader :name

  def initialize
    @name = 'lizard'
  end

  def >(other_move)
    other_move.class == Spock || other_move.class == Paper
  end

  def <(other_move)
    other_move.class == Scissors || other_move.class == Rock
  end
end

class Player
  MOVES = { rock: Rock.new,
            paper: Paper.new,
            scissors: Scissors.new,
            spock: Spock.new,
            lizard: Lizard.new }

  attr_accessor :moves, :name, :score

  def initialize
    set_name
    @score = 0
    @moves = []
  end

  def to_s
    "#{name}:".ljust(14) + "#{score} "
  end

  def current_move
    moves.last
  end

  def add_to_score
    self.score += 1
  end

  private

  def make_choice(player_choice)
    moves << MOVES.fetch(player_choice.to_sym)
  end
end

class Human < Player
  include AuxMethods

  def choose
    choice = nil
    loop do
      prompt "Please enter rock, paper, scissors, spock, or lizard:"
      choice = gets.chomp.downcase.strip
      break if MOVES.keys.include?(choice.to_sym)
      clear_screen
      prompt "Sorry, invalid choice."
    end
    make_choice(choice)
  end

  private

  def set_name
    n = ""
    loop do
      prompt "Please enter your name:"
      n = gets.chomp.strip
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end
end

class Computer < Player
  include AuxMethods

  PLAYERS = %w(r2d2 hal chappie sonnie number5)

  attr_reader :player

  def initialize
    @player = ask_what_player
    super
    display_chosen_player
  end

  def choose
    choice = player.class::PERSONALITY.sample
    make_choice(choice)
  end

  private

  def select_player(answer)
    case answer
    when 'r2d2'     then R2D2.new
    when 'hal'      then Hal.new
    when 'chappie'  then Chappie.new
    when 'sonnie'   then Sonnie.new
    when 'number5'  then Number5.new
    end
  end

  def ask_what_player
    answer = ''
    loop do
      prompt "Whom would you like to play against? Your choices are:"
      display_players
      answer = gets.chomp.downcase.strip
      break if answer == 'random' || PLAYERS.include?(answer)
      clear_screen
      puts "Sorry, please enter one of the options."
    end

    answer == 'random' ? select_player(PLAYERS.sample) : select_player(answer)
  end

  def display_players
    PLAYERS.each { |player| puts "\n-- #{player.capitalize}" }
    puts "\n-- Random"
  end

  def display_chosen_player
    prompt "You will be playing against #{name}!"
    begin_io
  end

  def set_name
    self.name = player.name
  end
end

class R2D2 < Computer
  PERSONALITY = %w(rock)

  def initialize
    self.name = 'R2D2'
  end
end

class Hal < Computer
  PERSONALITY = %w(rock scissors scissors scissors spock spock lizard lizard)

  def initialize
    self.name = 'Hal'
  end
end

class Sonnie < Computer
  PERSONALITY = %w(rock paper scissors)

  def initialize
    self.name = 'Sonnie'
  end
end

class Chappie < Computer
  PERSONALITY = %w(spock lizard)

  def initialize
    self.name = 'Chappie'
  end
end

class Number5 < Computer
  PERSONALITY = %w(rock paper scissors spock lizard)

  def initialize
    self.name = 'Number 5'
  end
end

class RPSGame
  WINNING_SCORE = 3
  include AuxMethods

  attr_accessor :human, :computer, :round, :round_winner

  def initialize
    clear_screen
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  private

  def display_welcome_message
    prompt "Welcome to RPSSL!"
    puts "First one to get #{WINNING_SCORE} points wins the match!"
  end

  def display_goodbye_message
    prompt "Thanks for playing RPSSL, #{human.name}. Goodbye!"
  end

  def display_moves
    puts "\n#{human.name} chose #{human.current_move.name}."
    puts "#{computer.name} chose #{computer.current_move.name}."
  end

  def set_round_winner
    self.round_winner =
      if human.current_move > computer.current_move
        human
      elsif human.current_move < computer.current_move
        computer
      end
  end

  def display_round_winner
    set_round_winner
    if round_winner
      prompt "#{round_winner.name} won!"
      round_winner.add_to_score
    else
      prompt "It's a tie!"
    end
    increment_round
  end

  def increment_round
    self.round += 1
  end

  def match_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def display_match_winner
    if human.score == WINNING_SCORE
      prompt "#{human.name} is the match winner!"
    elsif computer.score == WINNING_SCORE
      prompt "#{computer.name} is the match winner!"
    end

    display_score
  end

  def display_score
    prompt match_winner? ? "The final score is:" : "The current score is:"
    puts human
    puts computer

    next_round_io unless match_winner?
  end

  def play_again?
    answer = nil
    loop do
      prompt "Would you like to play another match? (y/n)"
      answer = gets.chomp.strip
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    reset_stats if answer.downcase == 'y'
  end

  def reset_stats
    @computer = Computer.new
    self.round = 1
    human.score = 0
    computer.score = 0
    human.moves = []
    computer.moves = []
  end

  def ask_to_show_moves
    answer = ''

    loop do
      prompt "Would you like to see the previous match's "\
      "move history of each round? (y/n)"
      answer = gets.chomp.strip
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return true if answer.downcase == 'y'
  end

  def display_all_moves(first_player, second_player)
    both_player_moves = first_player.moves.zip(second_player.moves)
    round = 1

    both_player_moves.each do |move|
      puts "Round #{round} #{first_player.name} played #{move.first.name}"\
      " and #{second_player.name} played #{move.last.name}."
      round += 1
    end
  end

  def players_choose_move
    human.choose
    computer.choose
    display_moves
  end

  def main_loop
    loop do
      players_choose_move
      display_round_winner
      if match_winner?
        display_match_winner
        break unless play_again?
      else
        display_score
      end
    end
  end

  public

  def play
    main_loop
    display_all_moves(human, computer) if ask_to_show_moves
    display_goodbye_message
  end
end

RPSGame.new.play
