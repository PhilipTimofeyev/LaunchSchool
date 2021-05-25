require 'io/console'

WINNING_SCORE = 5
TO_WHAT_NUM = 21

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
  prompt "Press any key for the dealer's turn"
  $stdin.getch
end

def final_result_io
  prompt "Press any key to see who the winner is"
  $stdin.getch
end

def welcome
  clear_screen
  prompt "Hello and welcome to #{TO_WHAT_NUM}!

  The goal is get your hand as close to #{TO_WHAT_NUM} as you can.
  Number cards are worth their resepective numbers,
  face cards are worth 10, and aces are worth either
  11 or 1, depending on your hand. At the end of
  the round, your total hand score will be compared to
  the dealer's. Whoever is closest to #{TO_WHAT_NUM}, wins! If you
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

def display_hand(p_hand, d_hand, totals)
  hand_arr = [[d_hand, 'Dealer has'], [p_hand, 'You have']]
  hand_arr.each do |hand|
    cards = hand[0][1..-1].map { |card| "#{card[0]} of #{card[1]}" }.join(', ')
    if hand == hand_arr[0]
      prompt "#{hand[1]}: #{cards} and unknown"
    else
      prompt "#{hand[1]}: #{cards} and #{hand[0][0][0]} of #{hand[0][0][1]}"\
      " with a total of #{totals[:player]}"
    end
  end
  puts ""
end

def display_final_hand(p_hand, d_hand, totals)
  hand_arr = [[d_hand, 'Dealer had'], [p_hand, 'You had']]

  hand_arr.each do |hand|
    cards = hand[0][1..-1].map { |card| "#{card[0]} of #{card[1]}" }.join(', ')
    if hand == hand_arr[0]
      prompt "#{hand[1]}: #{cards} and #{hand[0][0][0]} of #{hand[0][0][1]}"\
      " with a total of #{totals[:dealer]}"
    else
      prompt "#{hand[1]}: #{cards} and #{hand[0][0][0]} of #{hand[0][0][1]}"\
      " with a total of #{totals[:player]}"
    end
  end
  puts ""
end

# rubocop:enable Metrics/AbcSize

def hand_total(hand)
  total = hand.reduce(0) { |sum, num| sum + num[2] }
  how_many_aces(hand).times { total -= 10 if total > TO_WHAT_NUM }

  total
end

def how_many_aces(hand)
  hand.select { |cards| cards[0] == 'Ace' }.count
end

def busted?(hand)
  hand > TO_WHAT_NUM
end

def any_busts?(totals)
  busted?(totals[:player]) || busted?(totals[:dealer])
end

def player_turn(deck, p_hand, d_hand, totals, score)
  clear_screen
  player_hit_stay(deck, p_hand, d_hand, totals)
  if busted?(totals[:player])
    clear_screen
    prompt "You busted! Dealer wins!"
    score[:dealer] += 1
  else
    prompt "You chose to stay"
    false
  end
end

def player_hit_stay(deck, p_hand, d_hand, totals)
  answer = ''
  loop do
    totals[:player] = hand_total(p_hand)
    break if %w(s stay).include?(answer) || busted?(totals[:player])
    clear_screen
    display_hand(p_hand, d_hand, totals)
    loop do
      prompt "Hit or stay?"
      answer = gets.chomp.downcase
      break if %w(h hit s stay).include?(answer)
      prompt "Please enter Hit or Stay"
    end
    deal_card(deck, p_hand) if answer.start_with?('h')
  end
end

def dealer_hit_stay(deck, p_hand, d_hand, totals)
  loop do
    totals[:dealer] = hand_total(d_hand)
    break unless totals[:dealer] <= (TO_WHAT_NUM - 4)
    prompt "Dealer chooses to hit"
    deal_card(deck, d_hand)
    display_hand(p_hand, d_hand, totals)
    next_move_io
    clear_screen
  end
end

def dealer_turn(deck, p_hand, d_hand, totals, score)
  dealer_hit_stay(deck, p_hand, d_hand, totals)

  if busted?(totals[:dealer])
    prompt "Dealer busted! You won!"
    score[:player] += 1
  else
    prompt "Dealer chose to stay"
    final_result_io
  end
end

def winner(totals, score)
  clear_screen
  case totals[:player] <=> totals[:dealer]
  when 1
    score[:player] += 1
    prompt "You won!"
  when 0
    prompt "It's a tie!"
  when -1
    score[:dealer] += 1
    prompt "Dealer won!"
  end
end

def display_current_score(score)
  prompt "The current score is:
   You: #{score[:player]}
   Dealer: #{score[:dealer]}"
end

def display_final_score(score)
  match_winner = score.select { |_, v| v == WINNING_SCORE }

  if match_winner.key?(:player)
    prompt "You are the match winner!"
  else
    prompt "Dealer is the match winner!"
  end
  prompt "Match score is:
    Dealer: #{score[:dealer]}
    Player: #{score[:player]}"
end

def next_round?(score)
  display_current_score(score)
  answer = ''
  puts ""
  prompt "Move onto the next round? (Yes/No)"
  loop do
    answer = gets.chomp.downcase
    break if %w(n no y yes).include?(answer)
    prompt "Please enter yes or no"
  end
  answer.start_with?('n')
end

def another_match?
  answer = ''
  puts ""
  prompt "Play another match? (Yes/No)"
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
  score = { player: 0, dealer: 0 }
  loop do
    deck = init_deck
    player_hand = []
    dealer_hand = []
    totals = { player: 0, dealer: 0 }

    deal_inital_cards(deck, player_hand, dealer_hand)
    player_turn(deck, player_hand, dealer_hand, totals, score)
    if any_busts?(totals)
      totals[:dealer] = hand_total(dealer_hand)
    else
      dealer_turn(deck, player_hand, dealer_hand, totals, score)
    end
    winner(totals, score) unless any_busts?(totals)
    display_final_hand(player_hand, dealer_hand, totals)
    if score.values.any?(WINNING_SCORE)
      display_final_score(score)
      break
    end
    next_round?(score) ? break : next
  end
  break if another_match?
end
prompt "Thanks for playing!"
