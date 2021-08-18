require 'io/console'

module AuxMethods
  def center_text(text)
    puts text.center(Table::TABLE_SIZE)
  end
end

module Hand
  def show_hand
    cards_participants_can_see
  end

  def busted?
    total > 21
  end

  def how_many_aces
    hand.select { |card| card.face == 'Ace' }.count
  end

  def total
    total = hand.reduce(0) { |sum, card| sum + card.value }
    how_many_aces.times { total -= 10 if total > 21 }
    total
  end

  def display_total
    "Total is: #{total}"
  end

  def unknown_card
    hand.first
  end

  def cards_participants_can_see
    hand[1..-1].map(&:to_s).join(' ')
  end
end

class Participant
  include Hand, AuxMethods

  attr_accessor :name, :hand, :deck, :toggle

  def initialize(deck)
    @hand = []
    @deck = deck
    @toggle = false
  end

  def hit
    hand << deck.cards.pop
  end

  def display_hit
    center_text "#{self.name} chose to hit" #unless busted?
  end

  def stay
    center_text "#{self.name} chose to stay."
    dealer_turn_io if self.class == Player
  end

  def dealer_turn_io
    center_text "Press any key to continue to the dealer's turn."
    $stdin.getch
  end
end

class Player < Participant
  def initialize(deck)
    super
  end

  def hit_or_stay(answer)
    case answer
    when 'h' then hit
    when 's' then stay
    when 't' then toggle_player_hand
    end
  end

  def turn(table)
    answer = nil
    loop do
      table.draw
      display_player_choices
      display_hit if answer == 'h'
      answer = gets.chomp.downcase
      hit_or_stay(answer)
      break if answer == 's' || busted?
    end
    table.draw
  end

  def display_player_choices
    center_text "Would you like to (h)it or (s)tay?"
    center_text "Enter 't' to look at your hidden card and total."
  end

  def toggle_player_hand
    self.toggle = toggle ? false : true
  end

end

class Dealers < Participant
  OPPONENTS = ['rex (1)', 'arya (2)', 'hannibal (3)']

  attr_accessor :reveal_unknown
  attr_reader :risk

  def initialize(deck)
    super
    @reveal_unknown = false
  end

  def turn(table)
    loop do
      break unless total <= risk
      hit
      table.draw
      display_hit
      next_move_io
      break if busted?
    end
    table.draw
    stay_and_results_io unless busted?
  end

  def next_move_io
    center_text "Press any key for #{self.name}'s next move"
    $stdin.getch
  end

  def stay_and_results_io
    stay
    center_text "Press any key to see the results"
    $stdin.getch
  end
end

class Rex < Dealers
  def initialize(deck)
    super
    @name = 'Rex'
    @risk = 19
  end

  def welcome
    puts "How tough are ya?"
  end
end

class Hannibal < Dealers
  def initialize(deck)
    super
    @name = 'Hannibal Lector'
    @risk = madman_risk
  end

  def madman_risk
    (10..21).to_a.sample
  end
end

class AryaStark < Dealers
  def initialize(deck)
    super
    @name = 'Arya Stark'
    @risk = 17
  end
end

class Deck
  SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
  FACE_CARDS = ['Jack', 'Queen', 'King']

  attr_accessor :cards

  def initialize
    @cards = create_deck
    cards.shuffle!
  end

  def create_num_cards
    SUITS.each.with_object([]) do |suit, cards|
      (2..10).each { |num| cards << Card.new(suit, num, num) }
    end
  end

  def create_face_cards
    SUITS.each.with_object([]) do |suit, cards|
      FACE_CARDS.each { |face| cards << Card.new(suit, face, 10) }
      cards << Card.new(suit, 'Ace', 11)
    end
  end

  def create_deck
    (create_num_cards + create_face_cards)
  end
end

class Card
  attr_reader :suit, :face, :value

  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end

  def to_s
    "|#{face} of #{suit}|"
  end
end

class Table
  TABLE_SIZE = 100

  include AuxMethods

  attr_reader :player, :dealer
  attr_accessor :starting_table

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @starting_table = true
  end

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

  def draw
    clear
    puts "|" + table_empty_space('-') + "|"
    puts "|" + table_empty_space(' ') + "|"
    puts "|" + show_dealer_total.center(TABLE_SIZE) + "|"
    puts "|" + "#{show_dealer_unknown} #{show_dealer_hand}".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "-  #{dealer.name}  -".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "-  #{player.name}  -".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "#{show_player_unknown} #{show_player_hand}".center(TABLE_SIZE) + "|"
    puts "|" + show_player_total.center(TABLE_SIZE) + "|"
    puts "|" + table_empty_space(' ') + "|"
    puts "|" + table_empty_space('-') + "|"
    puts ""
  end

  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

  def table_empty_space(char)
    char * TABLE_SIZE
  end

  def show_dealer_hand
    dealer.show_hand unless starting_table
  end

  def show_player_hand
    player.show_hand unless starting_table
  end

  def show_dealer_total
    dealer.reveal_unknown ? dealer.display_total  : ""
  end

  def show_player_total
    player.toggle ? player.display_total  : ""
  end

  def show_player_unknown
    player.unknown_card if player.toggle
  end

  def show_dealer_unknown
    if dealer.reveal_unknown
      dealer.unknown_card
    elsif dealer.reveal_unknown
      "|    ?    |"
    end
  end
end

class Game
  include AuxMethods

  attr_accessor :deck, :player, :dealer
  attr_reader :table

  def initialize
    clear
    welcome
    @deck = Deck.new
    @player = Player.new(deck)
    ask_for_name
    @dealer = select_dealer
    @table = Table.new(player, dealer)
  end

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def welcome
    center_text "Hi and welcome to Twenty-One!"
    puts ""
  end

  def ask_for_name
    center_text "What is your name?"
    player_name = nil
    loop do
      player_name = gets.chomp.strip
      break unless name_validation(player_name)
      center_text "Sorry, please enter a name between 1 and 12 characters."
    end
    player.name = player_name
  end

  def name_validation(player_name)
    player_name.length >= 12 ||
    player_name.empty? ||
    Dealers::OPPONENTS.any? {|name| name.start_with?(player_name.downcase) } 
  end

  def ask_which_dealer
    center_text "Please select a dealer: #{list_opponents}"
    choice = nil
    loop do
      choice = gets.chomp.to_i
      break if [1, 2, 3, 4].include?(choice)
      center_text "Sorry, that's not a valid choice."
    end
    choice
  end

  def list_opponents
      Dealers::OPPONENTS.map(&:capitalize).join(', ')
  end

  def select_dealer
    case ask_which_dealer
    when 1 then Rex.new(deck)
    when 2 then AryaStark.new(deck)
    when 3 then Hannibal.new(deck)
    end
  end

  def begin_game_io
    center_text "Press any character to begin"
    $stdin.getch
  end

  def start
    match_loop
    display_goodbye
  end

  def match_loop
    table.draw
    begin_game_io
    deal_cards
    player_turn
    dealer_turn unless player.busted?
    show_result
  end

  def deal_cards
    begin_table_game
    2.times do
      dealer.hand << deck.cards.pop
      player.hand << deck.cards.pop
    end
  end

  def begin_table_game
    table.starting_table = false
  end

  def show_result
    table.draw
    if someone_busted?
      center_text player.busted? ? "Player busted! #{dealer.name} won!" : "#{dealer.name} busted! You won!"
    else
      determine_winner
    end
    reveal_table
  end

  def display_goodbye
    center_text "Thanks for playing Twenty-One! Goodbye!"
  end

  def reveal_table
    puts ""
    center_text "Press any key to reveal the table and totals"
    $stdin.getch
    player.toggle = true
    dealer.reveal_unknown = true
    table.draw
  end

  def determine_winner
    if player.total > dealer.total
      center_text "You won!"
    elsif dealer.total > player.total
      center_text "#{dealer.name} won!"
    else
      center_text "It's a tie!"
    end
  end

  def player_turn
    player.turn(table)
  end

  def dealer_turn
    dealer.turn(table)
  end

  def someone_busted?
    player.busted? || dealer.busted?
  end
end

Game.new.start
