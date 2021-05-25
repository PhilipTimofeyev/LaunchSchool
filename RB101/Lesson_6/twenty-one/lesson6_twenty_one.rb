require 'io/console'

def prompt(msg)
  puts "=> #{msg}"
end

def clear_screen
  Gem.win_platform? ? (system "cls") : (system "clear")
end

def start_game_io
  prompt "Press any key to start a game"
  $stdin.getch
end

def next_move_io
  prompt "Press any key for the dealer's next move."
  $stdin.getch
end

def final_result_io
  prompt "Press any key to see who the winner is"
  $stdin.getch
end

def welcome
  clear_screen
  prompt "Hello and welcome to Twenty-One!

  The goal is get your hand as close to a total of 21
  as you can. Number cards are worth their resepective
  numbers, face cards are worth 10, and aces are worth
  either 11, or 1, depending on your hand. At the end of
  the round, your total hand score will be compared to
  the dealer's. Whoever is closest to 21, wins! If you
  go over 21, then that's a bust and you lose!

  Ready to play?
  "
  start_game_io
end

def init_deck
  deck = []
  suits = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
  face_cards = ['Jack', 'Queen', 'King']

  suits.each do |suit|
    (2..10).each { |card| deck << [card.to_s, suit, card] }
    face_cards.each { |face| deck << [face, suit, 10] }
    deck << ["Ace", suit, 11]
  end
  deck.shuffle
end

def deal_inital_cards(deck, p_hand, d_hand)
  2.times do
    p_hand << deck.shift
    d_hand << deck.shift
  end
end

def deal_card(deck, hand)
  hand << deck.shift
end

# rubocop:disable Metrics/AbcSize

def display_hand(p_hand, d_hand)
  hand_arr = [[d_hand, 'Dealer has'], [p_hand, 'You have']]
  hand_arr.each do |hand|
    cards = hand[0][1..-1].map { |card| "#{card[0]} of #{card[1]}" }.join(', ')
    if hand == hand_arr[0]
      prompt "#{hand[1]}: #{cards} and unknown"
    else
      prompt "#{hand[1]}: #{cards} and #{hand[0][0][0]} of #{hand[0][0][1]}"\
      " with a total of #{hand_total(p_hand)}"
    end
  end
end

def display_final_hand(p_hand, d_hand)
  hand_arr = [[d_hand, 'Dealer had'], [p_hand, 'You had']]

  hand_arr.each do |hand|
    cards = hand[0][1..-1].map { |card| "#{card[0]} of #{card[1]}" }.join(', ')
    if hand == hand_arr[0]
      prompt "#{hand[1]}: #{cards} and #{hand[0][0][0]} of #{hand[0][0][1]}"\
      " with a total of #{hand_total(d_hand)}"
    else
      prompt "#{hand[1]}: #{cards} and #{hand[0][0][0]} of #{hand[0][0][1]}"\
      " with a total of #{hand_total(p_hand)}"
    end
  end
end

# rubocop:enable Metrics/AbcSize

def hand_total(hand)
  total = hand.reduce(0) { |sum, num| sum + num[2] }
  how_many_aces(hand).times { total -= 10 if total > 21 }

  total
end

def how_many_aces(hand)
  hand.select { |cards| cards[0] == 'Ace' }.count
end

def busted?(hand)
  hand_total(hand) > 21
end

def any_busts?(p_hand, d_hand)
  busted?(p_hand) || busted?(d_hand)
end

def winner(p_hand, d_hand)
  case hand_total(p_hand) <=> hand_total(d_hand)
  when 1
    prompt "You won!"
  when 0
    prompt "It's a tie!"
  when -1
    prompt "Dealer won!"
  end
end

def hit_or_stay(deck, p_hand, d_hand)
  loop do
    answer = ''
    clear_screen
    display_hand(p_hand, d_hand)
    loop do
      prompt "Hit or stay?"
      answer = gets.chomp.downcase
      break if %w(h hit s stay).include?(answer)
      prompt "Please enter Hit or Stay"
    end
    deal_card(deck, p_hand) if answer == "hit"
    break if %w(s stay).include?(answer) || busted?(p_hand)
  end
end

def player_turn(deck, p_hand, d_hand)
  hit_or_stay(deck, p_hand, d_hand)
  clear_screen
  if busted?(p_hand)
    prompt "You busted!"
    prompt "Dealer wins!"
  else
    prompt "You chose to stay"
    false
  end
end

def dealer_turn(deck, p_hand, d_hand)
  loop do
    break unless hand_total(d_hand) <= 17
    prompt "Dealer chooses to hit"
    deal_card(deck, d_hand)
    display_hand(p_hand, d_hand)
    next_move_io
    clear_screen
  end
  if busted?(d_hand)
    prompt "Dealer busted!"
    prompt "You won!"
  else
    prompt "Dealer chose to stay"
    final_result_io
  end
end

def play_again?
  answer = ''
  puts ""
  prompt "Play again? (Yes/No)"
  loop do
    answer = gets.chomp.downcase
    break if %w(n no y yes).include?(answer)
    prompt "Please enter yes or no"
  end
  answer.start_with?('n')
end

# Game

welcome
loop do
  deck = init_deck
  player_hand = []
  dealer_hand = []

  deal_inital_cards(deck, player_hand, dealer_hand)
  player_turn(deck, player_hand, dealer_hand)
  dealer_turn(deck, player_hand, dealer_hand) unless busted?(player_hand)
  winner(player_hand, dealer_hand) unless any_busts?(player_hand, dealer_hand)
  display_final_hand(player_hand, dealer_hand)
  break if play_again?
end
prompt "Thanks for playing!"
