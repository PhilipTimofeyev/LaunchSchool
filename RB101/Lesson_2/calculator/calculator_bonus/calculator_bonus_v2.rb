LANGUAGE = 'en' # en for English and es for Spanish

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def clear_screen
  Gem.win_platform? ? (system "cls") : (system "clear")
end

def integer?(input)
  /^-?\d+$/.match(input)
end

def valid_name(name)
  name.empty? || name[0] == ' '
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  operation_to_message_hsh = {
    '1': 'Adding',
    '2': 'Subtracting',
    '3': 'Multiplying',
    '4': 'Dividing'
  }
  operation_to_message_hsh[op.to_sym]
end

def greet_name
  clear_screen
  prompt 'welcome'
  name = ''
  loop do
    name = gets.chomp
    if valid_name(name)
      prompt('valid_name')
    else
      prompt('greeting')
      break
    end
  end
  name
end

def get_number_1
  number = ''

  prompt('first_number')
  loop do
    number = gets.chomp
    number?(number) ? break : prompt('invalid_number')
  end
  number
end

def get_number_2
  number = ''

  prompt('second_number')
  loop do
    number = gets.chomp
    number?(number) ? break : prompt('invalid_number')
  end
  number
end

def which_operator
  clear_screen
  prompt('operator_prompt')
  operator = ''

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('choose')
    end
  end
  operator
end

def divided_by_zero?(operator, number2)
  if number2 == 0 && operator == '4'
    prompt('divide_by_zero')
    sleep(2)
    clear_screen
    true
  else
    false
  end
end

def calculate(number1, number2, operator)
  puts "=> #{operation_to_message(operator)} the two numbers..."
  sleep(2)
  case operator.to_s
  when '1'
    number1 + number2
  when '2'
    number1 - number2
  when '3'
    number1 * number2
  when '4'
    number1 / number2
  end
end

def display_solution(result)
  clear_screen
  if result == result.to_i
    result = result.to_i
  else
    result = format('%g', result)
  end
  puts format(messages('result', LANGUAGE), result: result)
end

def do_again?
  response = ''
  prompt('again')
  loop do
    response = gets.chomp.downcase
    %w(y n).include?(response) ? break : prompt('invalid_response')
  end
  response.start_with?('y')
end

def calc_loop
  loop do
    number1 = get_number_1.to_f
    operator = which_operator
    number2 = get_number_2.to_f
    redo if divided_by_zero?(operator, number2) == true
    solution = calculate(number1, number2, operator)
    display_solution(solution)
    break unless do_again?
  end
  clear_screen
end

greet_name
calc_loop
prompt('goodbye')
