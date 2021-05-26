require 'io/console'

WINNING_SCORE = 5
TO_WHAT_NUM = 21
SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']
FACE_CARDS = ['Jack', 'Queen', 'King']

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
  go over #{TO_WHAT_NUM}, then that's a bust and you lose!

  Ready to play?
  "
  start_game_io
end

def create_num_cards
  num_cards = []
  SUITS.each do |suit|
    (2..10).each do |num|
      card = Hash.new
      card[:face] = num.to_s
      card[:suit] = suit
      card[:value] = num
      num_cards << card
    end
  end
  num_cards
end

def create_face_cards
  face_cards = []
  SUITS.each do |suit|
    FACE_CARDS.each do |face|
      card = Hash.new
      card[:face] = face
      card[:suit] = suit
      card[:value] = 10
      face_cards << card
    end
    face_cards << { face: 'Ace', suit: suit, value: 11 }
  end
  face_cards
end

def init_deck
  deck = create_num_cards
  deck += create_face_cards
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

def what_cards_to_show(hand)
  hand[1..-1].map { |card| "#{card[:face]} of #{card[:suit]}" }.join(', ')
end

def display_hand(hand, totals, who, player: true, end_round: false)
  cards = what_cards_to_show(hand)
  who_turn = player ? 'Your hand' : 'Dealer hand'

  if player || (!player && end_round)
    prompt "#{who_turn}: #{cards} and #{hand[0][:face]} of #{hand[0][:suit]}"\
    " with a total of #{totals[who.to_sym]}"
  else
    prompt "Dealer hand: #{cards} and unknown"
  end
  puts ""
end

def hand_total(hand)
  total = hand.reduce(0) { |sum, card| sum + card[:value] }
  how_many_aces(hand).times { total -= 10 if total > TO_WHAT_NUM }

  total
end

def how_many_aces(hand)
  hand.select { |cards| cards[:face] == 'Ace' }.count
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

def acquire_player_choice
  answer = ''
  loop do
    prompt "Hit or stay?"
    answer = gets.chomp.downcase.strip
    break if %w(h hit s stay).include?(answer)
    prompt "Please enter Hit or Stay"
  end
  answer
end

def player_hit_stay(deck, p_hand, d_hand, totals)
  answer = ''
  loop do
    totals[:player] = hand_total(p_hand)
    break if %w(s stay).include?(answer) || busted?(totals[:player])
    clear_screen
    display_hand(p_hand, totals, 'player')
    display_hand(d_hand, totals, 'dealer', player: false)
    answer = acquire_player_choice
    deal_card(deck, p_hand) if answer.start_with?('h')
  end
end

def dealer_hit_stay(deck, d_hand, totals)
  loop do
    totals[:dealer] = hand_total(d_hand)
    break unless totals[:dealer] <= (TO_WHAT_NUM - 4)
    prompt "Dealer chooses to hit"
    deal_card(deck, d_hand)
    display_hand(d_hand, totals, 'dealer', player: false)
    next_move_io
    clear_screen
  end
end

def dealer_turn(deck, d_hand, totals, score)
  dealer_hit_stay(deck, d_hand, totals)

  if busted?(totals[:dealer])
    prompt "Dealer busted! You won!"
    score[:player] += 1
  else
    prompt "Dealer chose to stay"
    final_result_io
  end
end

def round_winner(totals)
  clear_screen
  case totals[:player] <=> totals[:dealer]
  when 1
    prompt "You won!"
    'player'
  when 0
    prompt "It's a tie!"
  when -1
    prompt "Dealer won!"
    'dealer'
  end
end

def update_score(score, winner)
  case winner
  when 'player'
    score[:player] += 1
  when 'dealer'
    score[:dealer] += 1
  end
end

def display_current_score(score)
  prompt "The current score is:
   You: #{score[:player]}
   Dealer: #{score[:dealer]}"
end

def display_match_score(score)
  if match_winner(score) == 'player'
    prompt "You are the match winner!"
  else
    prompt "Dealer is the match winner!"
  end
  puts ""
  prompt "Match score is:
    Dealer: #{score[:dealer]}
    Player: #{score[:player]}"
end

def match_winner(score)
  if score[:player] == WINNING_SCORE
    'player'
  elsif score[:dealer] == WINNING_SCORE
    'dealer'
  end
end

def next_round?(score)
  display_current_score(score)
  answer = ''
  puts ""
  prompt "Move onto the next round? (Yes/No)"
  loop do
    answer = gets.chomp.downcase.strip
    break if %w(n no y yes).include?(answer)
    prompt "Please enter yes or no"
  end
  answer.start_with?('y')
end

def another_match?
  answer = ''
  puts ""
  prompt "Play another match? (Yes/No)"
  loop do
    answer = gets.chomp.downcase.strip
    break if %w(n no y yes).include?(answer)
    prompt "Please enter yes or no"
  end
  answer.start_with?('y')
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
      dealer_turn(deck, dealer_hand, totals, score)
    end
    unless any_busts?(totals)
      winner = round_winner(totals)
      update_score(score, winner)
    end
    display_hand(player_hand, totals, 'player')
    display_hand(dealer_hand, totals, 'dealer', player: false, end_round: true)
    if match_winner(score)
      display_match_score(score)
      break
    end
    break unless next_round?(score)
  end
  break unless another_match?
end
prompt "Thanks for playing!"
