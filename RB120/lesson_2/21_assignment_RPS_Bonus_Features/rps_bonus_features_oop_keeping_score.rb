require 'io/console'

module OtherMethods
  def prompt(msg)
    puts "\n=> #{msg}"
  end

  def clear_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end

  def add_to_score
    self.score += 1
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
      prompt "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      prompt "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  include OtherMethods

  WINNING_SCORE = 2

  attr_accessor :human, :computer, :round, :round_winner

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @round = 1
  end

  def display_welcome_message
    prompt "Welcome to Rock, Paper, Scissor, #{human.name}!"
    puts "First one to get 10 points, wins!"
    start_io
  end

  def display_goodbye_message
    prompt "Thanks for playing Rock, Paper, Scissor. Goodbye!"
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
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
