ROUNDS = 5

PRINT_CHOICES =
  "\n  ~ Rock(r)
  ~ Paper(p)
  ~ Scissors(s)
  ~ Spock(sp)
  ~ Lizard(l)"

CHOICES_HSH = {
  rock: ['r', 'rock'],
  scissors: ['s', 'scissors'],
  paper: ['p', 'paper'],
  spock: ['sp', 'spock'],
  lizard: ['l', 'lizard']
}

WINNING_HSH = {
  rock: ['scissors', 'lizard'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['paper', 'spock'],
  spock: ['scissors', 'rock']
}

def prompt(message)
  puts "=> #{message}"
end

def display_newline
  puts " "
end

def clear_screen
  Gem.win_platform? ? (system "cls") : (system "clear")
end

def welcome
  clear_screen
  prompt("Hi and welcome to Rock Paper Scissors!")
  sleep(1)
  prompt("First player to reach #{ROUNDS}, wins!
    \n")
  sleep(1)
end

def display_valid_choice
  prompt("That's not a valid choice.")
  sleep(2)
  clear_screen
end

def get_user_choice
  user_choice = ''

  loop do
    prompt("Please enter one of the following: #{PRINT_CHOICES}")
    input = gets.chomp.downcase

    if CHOICES_HSH.values.flatten.include?(input)
      CHOICES_HSH.each do |_key, value|
        value.include?(input) ? user_choice = CHOICES_HSH.key(value).to_s : nil
      end
    else
      display_valid_choice
    end

    break if user_choice != ''
  end
  user_choice
end

def get_computer_choice
  CHOICES_HSH.keys.sample.to_s
end

def display_choices(player, computer)
  clear_screen
  prompt("You chose: #{player.capitalize}
=> Computer chose: #{computer.capitalize}")
end

def who_wins?(player, computer)
  WINNING_HSH.keys.include?(player) &&
    WINNING_HSH.fetch(player).include?(computer)
end

def update_counter_player(player, computer)
  who_wins?(player.to_sym, computer) ? 1 : 0
end

def update_counter_computer(player, computer)
  who_wins?(computer.to_sym, player) ? 1 : 0
end

def display_results(player, computer)
  if who_wins?(player.to_sym, computer)
    prompt("You won!")
  elsif who_wins?(computer.to_sym, player)
    prompt("Computer Won!")
  else
    prompt("It's a tie!")
  end
  display_newline
end

def display_current_score(player, computer)
  if (player == ROUNDS) || (computer == ROUNDS)
    prompt("Final score is:
    You: #{player}
    Computer: #{computer}
    \n")
  else
    prompt("Current score is:
    You: #{player}
    Computer: #{computer}
    \n")
  end
  sleep(1)
end

def valid_exit(round)
  do_again = nil
  loop do
    answer = gets.chomp.downcase
    if answer.start_with?('n')
      prompt("Starting round #{round}")
      sleep(1)
      do_again = false
      break
    elsif answer.start_with?('q')
      do_again = true
      break
    else puts "Invalid response. Please enter a valid response."
    end
  end
  do_again
end

def calculate_winner(player, computer)
  if player == ROUNDS
    'player'
  elsif computer == ROUNDS
    'computer'
  end
end

def display_winner(victor)
  if victor == 'player'
    prompt("You are the match victor!")
  else
    prompt("Computer is the match victor!
      \n")
  end
end

def end_of_match?(player, computer, round)
  if (player == ROUNDS) || (computer == ROUNDS)
    true
  else
    prompt("Enter 'n' to start next round or 'q' to quit the match?")
    valid_exit(round)
    false
  end
end

def game_loop(player_score, computer_score, round)
  loop do
    user_choice = get_user_choice
    computer_choice = get_computer_choice
    display_choices(user_choice, computer_choice)
    display_results(user_choice, computer_choice)
    player_score += (update_counter_player(user_choice, computer_choice))
    computer_score += update_counter_computer(user_choice, computer_choice)
    display_current_score(player_score, computer_score)
    winner = calculate_winner(player_score, computer_score)
    display_winner(winner)
    break if end_of_match?(player_score, computer_score, round)
    round += 1
    clear_screen
  end
end

def quit_game?
  prompt("Play another match? (Y/N)")
  answer = gets.chomp.downcase
  answer.include?('n')
end

def match_loop
  loop do
    player_score = 0
    computer_score = 0
    round = 2

    game_loop(player_score, computer_score, round)
    break if quit_game?
    prompt("Starting new match...")
    sleep(2)
    clear_screen
  end
end

def goodbye
  prompt("Thank you for playing. Goodbye!")
end

welcome
match_loop
goodbye
