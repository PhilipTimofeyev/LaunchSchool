def integer?(num)
  (num.to_i.to_s == num) && num.to_i >= 0
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def number?(input)
  integer?(input) || float?(input)
end

def prompt(message)
  puts "=> #{message}"
end

loan_amount = ''
apr = ''
loan_duration = ''

prompt "Hello and welcome to the Mortgage/Car Loan Calculator"

prompt "You will need to provide three pieces of information:
  - the loan amount
  - the Annual Percentage Rate (APR)
  - the loan duration in months"

loop do
  prompt "Please enter the loan amount"
  loop do
    loan_amount = gets.chomp

    if float?(loan_amount) && !loan_amount.empty?
      break
    else
      prompt "Please enter a positive number for the loan amount."
    end
  end

  prompt "Please enter the Annual Percentage Rate (APR) as a percentage."

  loop do
    apr = gets.chomp

    if number?(apr) && !apr.empty?
      break
    else
      prompt "Please enter a positive number for the APR."
    end
  end

  prompt "Please enter the loan duration in months."

  loop do
    loan_duration = gets.chomp

    if integer?(loan_duration) && !loan_duration.empty?
      break
    else
      prompt "Please enter a positive whole number for the loan durations."
    end
  end

  monthly_interest_rate = apr.to_f / 1200

  monthly_payment = loan_amount.to_f * (monthly_interest_rate /
    (1 - (1 + monthly_interest_rate)**(-loan_duration.to_i)))

  prompt "Your monthly payment will be $#{monthly_payment.ceil(2)}"

  prompt "Would you like to calculate a different monthly rate?
  (Please type Y or N)"
  response = gets.chomp.downcase

  if response == 'n'
    prompt "Thank you for using the Mortgage/Car Loan Calculator!"
    break
  end
end
