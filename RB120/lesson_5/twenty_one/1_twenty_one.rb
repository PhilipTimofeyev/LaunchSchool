require 'io/console' 

module Hand

  def show_hand
    cards_players_can_see
  end

  def busted?
    total > 21
  end

  def how_many_aces
    hand.select { |card| card.face == 'Ace' }.count
  end

  def determine_total
    self.total = hand.reduce(0) { |sum, card| sum + card.value }
    how_many_aces.times { self.total -= 10 if total > 21 }
  end

  def display_total
    "Total is: #{total}"
  end

  def unknown_card
    hand.first
  end

  def cards_players_can_see
    hand[1..-1].map(&:to_s).join(' ')
  end

end

class Participant
  include Hand

  attr_accessor :hand, :deck, :total, :toggle

  def initialize(deck)
    @hand = []
    @deck = deck
    @total = 0
    @toggle = false
  end

  def hit
    hand << deck.current.pop
  end

  def stay
    puts "#{self.class} chose to stay."
  end
end

class Player < Participant

  def initialize(deck)
    super
  end

  def turn(answer)
    case answer
    when 'h' then hit
    when 's' then stay
    end
  end

  def toggle_player_hand
    if toggle
       self.toggle = false
    else
     self.toggle = true
    end
  end
end

class Dealer < Participant

  def initialize(deck)
    super
  end

  def turn
    loop do

      break unless total <= 17
      puts "Dealer chooses to hit"
      hit
      determine_total
      sleep(2)
      break if busted?
    end
    puts "Dealer chose to stay." unless busted?
  end
end

class Deck
  SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
  FACE_CARDS = ['Jack', 'Queen', 'King']

  attr_accessor :current

  def initialize
    @current = create_deck
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
    (create_num_cards + create_face_cards).shuffle
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
  
end

class Game
  TABLE_SIZE = 80
  attr_accessor :deck, :player, :dealer
  #attr_reader :table

  def initialize
    clear
    @deck = Deck.new
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
  end

  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def start
    deal_cards
    player_turn
    dealer_turn unless player.busted?
    show_result
  end

  def draw_table
    clear
    puts "|" + table_empty_space('-') + "|"
    puts "|" + table_empty_space(' ') + "|"
    puts "|" + "#{show_dealer_total}".center(TABLE_SIZE) + "|"
    puts "|" + "#{show_dealer_unknown} #{dealer.show_hand}".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "-  Dealer  -".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "-  Player  -".center(TABLE_SIZE) + "|"
    2.times { puts "|" + table_empty_space(' ') + "|" }
    puts "|" + "#{show_player_unknown} #{player.show_hand}".center(TABLE_SIZE) + "|"
    puts "|" + "#{show_player_total}".center(TABLE_SIZE) + "|"
    puts "|" + table_empty_space(' ') + "|"
    puts "|" + table_empty_space('-') + "|"
    puts ""
  end

  def table_empty_space(char)
    char * TABLE_SIZE
  end

  def deal_cards
    2.times do
      dealer.hand << deck.current.pop
      player.hand << deck.current.pop
    end
  end

  def show_result
    player.toggle = true
    dealer.toggle = true
    draw_table
    if someone_busted?
      puts player.busted? ? "Player busted!" : "Dealer busted!"
    end
  end

  def show_player_unknown
    player.unknown_card if player.toggle
  end

  def show_dealer_unknown
    dealer.unknown_card if dealer.toggle
  end

  def show_player_total
    player.display_total if player.toggle
  end

  def show_dealer_total
    dealer.display_total if dealer.toggle
  end

  def dealer_turn
    dealer.turn
  end

  def someone_busted?
    player.busted? || dealer.busted?
  end

  def player_turn
    answer = nil
    loop do
      draw_table
      puts "Would you like to (h)it or (s)tay".center(TABLE_SIZE)
      puts "Enter 't' to look at your hidden card and total.".center(TABLE_SIZE)
      answer = gets.chomp
      player.toggle_player_hand if answer == 't'
      player.turn(answer)
      player.determine_total
      break if answer == 's' || player.busted?
    end
  end
end

Game.new.start