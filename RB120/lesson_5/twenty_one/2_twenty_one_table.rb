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

  attr_accessor :hand, :deck, :toggle, :starting_toggle

  def initialize(deck)
    @hand = []
    @deck = deck
    @toggle = false
    @starting_toggle = false
  end

  def hit
    hand << deck.cards.pop
  end

  def display_hit
    center_text "#{self.class} chose to hit" unless busted?
  end

  def stay
    center_text "#{self.class} chose to stay."
    dealer_turn_io unless self.class == Dealer
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
      answer = gets.chomp
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

  def dealer_turn_io
    center_text "Press any key to continue to dealer's turn."
    $stdin.getch
  end
end

class Dealer < Participant
  def initialize(deck)
    super
  end

  def turn(table)
    loop do
      break unless total <= 17
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
    center_text "Press any key for dealer's next move"
    $stdin.getch
  end

  def stay_and_results_io
    stay
    center_text "Press any key to see the results"
    $stdin.getch
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

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
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
    puts "|" + "-  Dealer  -".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "-  Player  -".center(TABLE_SIZE) + "|"
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
    dealer.show_hand if dealer.starting_toggle
  end

  def show_player_hand
    player.show_hand if player.starting_toggle
  end

  def show_dealer_total
    dealer.toggle ? dealer.display_total  : ""
  end

  def show_player_total
    player.toggle ? player.display_total  : ""
  end

  def show_player_unknown
    player.unknown_card if player.toggle
  end

  def show_dealer_unknown
    if dealer.toggle
      dealer.unknown_card
    elsif dealer.starting_toggle
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
    @deck = Deck.new
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
    @table = Table.new(player, dealer)
  end

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def start
    table.draw
    sleep(1)
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
    player.starting_toggle = true
    dealer.starting_toggle = true
  end

  def show_result
    player.toggle = true
    dealer.toggle = true
    table.draw
    if someone_busted?
      center_text player.busted? ? "Player busted!" : "Dealer busted!"
    else
      determine_winner
    end
  end

  def determine_winner
    if player.total > dealer.total
      center_text "You won!"
    elsif dealer.total > player.total
      center_text "Dealer won!"
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
