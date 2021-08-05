require 'io/console'

module OtherMethods
  def prompt(msg)
    puts "\n=> #{msg}"
  end

  def clear_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
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
  MOVES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def add_to_score
    self.score += 1
  end

  def make_choice(player_choice)
    case player_choice
    when 'rock' then self.move = Rock.new
    when 'paper'then self.move = Paper.new
    when 'scissors' then self.move = Scissors.new
    when 'spock' then self.move = Spock.new
    when 'lizard' then self.move = Lizard.new
    end
  end

  def to_s
    "#{name} with".ljust(18) + "#{score} points."
  end
end

class Human < Player
  include OtherMethods

  def set_name
    n = ""
    loop do
      puts "Please enter your name:"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    clear_screen
    choice = nil
    loop do
      prompt "Please enter rock, paper, scissors, spock, or lizard:"
      choice = gets.chomp
      break if MOVES.include? choice
      prompt "Sorry, invalid choice."
    end
    make_choice(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = MOVES.sample
    make_choice(choice)
  end
end

class RPSGame
  WINNING_SCORE = 2
  include OtherMethods

  attr_accessor :human, :computer, :round, :round_winner

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  def display_welcome_message
    prompt "Welcome to RPSSL, #{human.name}!"
    puts "First one to get 10 points, wins!"
    start_io
  end

  def display_goodbye_message
    prompt "Thanks for playing RPSSL. Goodbye!"
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move.name}."
    puts "#{computer.name} chose #{computer.move.name}."
  end

  def set_round_winner
    self.round_winner =
      if human.move > computer.move
        human
      elsif human.move < computer.move
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

  def increment_round
    self.round += 1
  end

  def display_score
    prompt match_winner? ? "The final score is:" : "The current score is:"
    puts human
    puts computer

    next_round_io unless match_winner?
  end

  def start_io
    prompt "Press any key to start."
    $stdin.getch
  end

  def next_round_io
    prompt "Press any key to start round #{round}."
    $stdin.getch
  end

  def play_again?
    answer = nil
    loop do
      prompt "Would you like to play another match? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    reset_stats if answer.downcase == 'y'
  end

  def reset_stats
    self.round = 1
    human.score = 0
    computer.score = 0
    clear_screen
  end

  def players_choose
    human.choose
    computer.choose
    display_moves
  end

  def main_loop
    loop do
      players_choose
      display_round_winner
      if match_winner?
        display_match_winner
        break unless play_again?
      else
        display_score
      end
    end
  end

  def play
    display_welcome_message
    main_loop
    display_goodbye_message
  end
end

RPSGame.new.play
