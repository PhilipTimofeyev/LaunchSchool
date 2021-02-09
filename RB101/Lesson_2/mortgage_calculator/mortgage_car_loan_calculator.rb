LANGUAGE = 'en' # en = English/ fr = French

require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  puts("=> #{message}")
end

def clear_screen
  Gem.win_platform? ? (system "cls") : (system "clear")
end

def integer?(num)
  /^-?\d+$/.match(num)
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def number?(input)
  integer?(input) || float?(input)
end

def valid_number?(number)
  (float?(number) || integer?(number)) && !number.empty? && number.to_f > 0
end

def welcome
  clear_screen
  prompt('welcome')
end

def loan_amount
  loan_amount = ''
  prompt('loan_entry')
  loop do
    loan_amount = gets.chomp
    valid_number?(loan_amount) ? break : prompt('positive_number')
  end
  loan_amount.to_f
end

def annual_percentage
  clear_screen
  apr = ''
  prompt('apr_entry')
  loop do
    apr = gets.chomp
    valid_number?(apr) ? break : prompt('positive_number')
  end
  apr.to_f / 1200
end

def loan_duration
  clear_screen
  duration = ''
  prompt('duration_entry')
  loop do
    duration = gets.chomp
    valid_number?(duration) && integer?(duration) ? break : prompt('whole#?')
  end
  duration.to_i
end

def compute(principal, monthly_interest_rate, months)
  principal *
    (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-months)))
end

def show_result(monthly_payment)
  puts format(messages('result', LANGUAGE), monthly_payment: monthly_payment)
end

def new_calculation?
  puts "\n"
  response = ''
  prompt('do_again?')
  loop do
    response = gets.chomp.downcase
    %w(y n).include?(response) ? break : prompt('invalid_response')
  end
  response
end

def mortgage_loop
  response = ''
  until response == 'n'
    principal             = loan_amount
    monthly_interest_rate = annual_percentage
    months                = loan_duration
    monthly_payment       = format(
      '%.2f', compute(principal, monthly_interest_rate, months)
    )
    clear_screen
    show_result(monthly_payment)
    response = new_calculation?
  end
  clear_screen
  prompt('goodbye')
end

welcome
mortgage_loop
