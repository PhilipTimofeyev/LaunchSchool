require 'io/console'

module AuxMethods
  def clear
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def center_text(text)
    puts text.center(Table::TABLE_SIZE)
  end
end

module Hand
  def show_hand
    cards_participants_can_see
  end

  def busted?
    total > TwentyOne::BUST_PAST
  end

  def total
    total = hand.reduce(0) { |sum, card| sum + card.value }
    how_many_aces.times { total -= 10 if total > TwentyOne::BUST_PAST }
    total
  end

  def display_total
    "Total is: #{total}"
  end

  def unknown_card
    hand.first
  end

  def how_many_aces
    hand.select { |card| card.face == 'Ace' }.count
  end

  def cards_participants_can_see
    hand[1..-1].map(&:to_s).join(' ')
  end
end

class Participant
  include Hand, AuxMethods

  attr_accessor :name, :hand, :deck, :show_hidden

  def initialize(deck)
    @hand = []
    @deck = deck
    @show_hidden = false
  end

  private

  def hit
    hand << deck.cards.pop
  end

  def display_hit
    center_text "#{name} chose to hit" unless busted?
  end

  def dealer_turn_io
    center_text "Press any key to continue to the dealer's turn."
    $stdin.getch
  end
end

class Player < Participant
  def turn(table)
    answer = nil
    loop do
      draw_and_display_player_choices(table)
      display_hit if answer == 'h'
      answer = gets.chomp.downcase
      hit_and_toggle(answer)
      break if answer == 's' || busted?
      display_invalid_answer(answer)
    end
    stay(table) unless busted?
  end

  private

  def hit_and_toggle(answer)
    case answer
    when 'h' then hit
    when 't' then toggle_player_hand
    end
  end

  def stay(table)
    table.draw
    center_text "#{name} chose to stay."
    sleep(1)
    puts ""
  end

  def draw_and_display_player_choices(table)
    table.draw
    center_text "Enter 't' to look at all of your cards and total."
    puts ""
    center_text "Would you like to (h)it or (s)tay?"
    puts ""
  end

  def display_invalid_answer(answer)
    return if %w(h t).include?(answer)
    center_text "Please enter 's' to stay or 'h' to hit."
    sleep(2)
  end

  def toggle_player_hand
    self.show_hidden = show_hidden ? false : true
  end
end

class Dealers < Participant
  OPPONENTS = { 1 => 'rex', 2 => 'arya stark', 3 => 'hannibal lector' }

  def turn(table)
    loop do
      break if total >= risk
      hit
      table.draw
      display_hit
      break if busted?
      next_move_io
    end
    table.draw
    stay_and_results_io unless busted?
  end

  private

  attr_reader :risk

  def stay
    center_text "#{name} chose to stay."
    puts ""
  end

  def next_move_io
    puts ""
    center_text "Press any key for #{name}'s next move."
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
    @risk = TwentyOne::BUST_PAST - 1
  end
end

class Hannibal < Dealers
  def initialize(deck)
    super
    @name = 'Hannibal Lector'
    @risk = madman_risk
  end

  def madman_risk
    (10..TwentyOne::BUST_PAST).to_a.sample
  end
end

class AryaStark < Dealers
  def initialize(deck)
    super
    @name = 'Arya Stark'
    @risk = TwentyOne::BUST_PAST - 4
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
    create_num_cards + create_face_cards
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
  TABLE_SIZE = 78

  include AuxMethods

  attr_reader :player, :dealer
  attr_accessor :starting_table

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @starting_table = true
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

  private

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
    dealer.show_hidden ? dealer.display_total : ""
  end

  def show_player_total
    player.show_hidden ? player.display_total : ""
  end

  def show_player_unknown
    player.unknown_card if player.show_hidden
  end

  def show_dealer_unknown
    if dealer.show_hidden
      dealer.unknown_card
    elsif !starting_table
      "|    ?    |"
    end
  end
end

class TwentyOne
  include AuxMethods

  BUST_PAST = 21

  attr_accessor :deck, :player, :dealer, :table

  def initialize
    clear
    welcome
    @deck = Deck.new
    @player = Player.new(deck)
    ask_for_name
    @dealer = select_dealer
    @table = Table.new(player, dealer)
  end

  def start
    match_loop
    display_goodbye
  end

  private

  def match_loop
    loop do
      begin_game_io
      deal_cards
      player_turn
      dealer_turn unless player.busted?
      show_result
      break unless another_round?
      reset_round
    end
  end

  def welcome
    center_text "Hi and welcome to Twenty-One!"
    puts ""
    puts "        The goal is get your hand as close to #{BUST_PAST} as you can.
        Number cards are worth their resepective numbers,
        face cards are worth 10, and aces are worth either
        11 or 1, depending on your hand.

        At the end of the round, your total hand score will
        be compared to the dealer's. Whoever is closest to #{BUST_PAST},
        wins! If you go over #{BUST_PAST}, then that's a bust and you lose!"
    puts ""
  end

  def ask_for_name
    center_text "Please enter your name:"
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
      Dealers::OPPONENTS.any? { |_, name| name == player_name.downcase }
  end

  def ask_which_dealer
    center_text "Please enter 1, 2, or 3, to select a dealer:"
    center_text list_opponents
    choice = nil
    loop do
      choice = gets.chomp.to_f
      break if [1, 2, 3, 4].include?(choice)
      center_text "Sorry, that's not a valid choice."
    end
    choice
  end

  def list_opponents
    Dealers::OPPONENTS.map do |num, name|
      "(#{num}) #{name.capitalize}"
    end.join(', ')
  end

  def select_dealer
    case ask_which_dealer
    when 1 then Rex.new(deck)
    when 2 then AryaStark.new(deck)
    when 3 then Hannibal.new(deck)
    end
  end

  def begin_game_io
    table.draw
    center_text "Press any key to begin"
    $stdin.getch
  end

  def deal_cards
    show_table_cards
    2.times do
      dealer.hand << deck.cards.pop
      player.hand << deck.cards.pop
    end
  end

  def show_table_cards
    table.starting_table = false
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

  def display_someone_busted
    if player.busted?
      center_text "#{player.name} chose to hit and busted! #{dealer.name} won!"
    else
      center_text "#{dealer.name} chose to hit and busted! You won!"
    end
  end

  def determine_winner
    if player.total > dealer.total
      player
    elsif dealer.total > player.total
      dealer
    end
  end

  def display_winner
    if determine_winner
      center_text "#{determine_winner.name} won!"
    else
      center_text "It's a tie!"
    end
  end

  def reveal_table_io
    puts ""
    center_text "Press any key to reveal the table and totals"
    $stdin.getch
    player.show_hidden = true
    dealer.show_hidden = true
    table.draw
  end

  def show_result
    table.draw
    if someone_busted?
      display_someone_busted
    else
      display_winner
    end
    reveal_table_io
  end

  def another_round?
    answer = ''
    loop do
      center_text "Would you like to play another round? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      center_text "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def reset_round
    self.deck = Deck.new
    self.dealer = select_dealer
    reset_player_hand
    self.table = Table.new(player, dealer)
    reset_table_display
  end

  def reset_player_hand
    player.hand = []
  end

  def reset_table_display
    player.show_hidden = false
  end

  def display_goodbye
    center_text "Thanks for playing Twenty-One! Goodbye!"
    puts ""
  end
end

TwentyOne.new.start
