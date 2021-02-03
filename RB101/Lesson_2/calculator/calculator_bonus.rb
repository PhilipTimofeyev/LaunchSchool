LANGUAGE = 'es'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')



def prompt(key)
  def messages(message, lang='en')
    MESSAGES[lang][message]
  end
  message = messages(key, LANGUAGE)   
  Kernel.puts("=> #{message}")
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

def number?(input)
  integer?(input) || float?(input)
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt('welcome')

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt "Hi #{name}!"

loop do
  number1 = ''
  number2 = ''
  loop do
    prompt(MESSAGES['first_number'])
    number1 = gets.chomp

    if number?(number1)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  loop do
    prompt(MESSAGES['second_number'])
    number2 = gets.chomp

    if number?(number2)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  prompt(MESSAGES['operator_prompt'])

  operator = ''

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['choose'])
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers."

  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt "The result is #{result}"

  prompt(MESSAGES['again'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'])
