def fizzbuzz(num1, num2)
  result = []
  num1.upto(num2) do |num|
    case
    when num % 3 == 0 && num % 5 == 0
      result << 'FizzBuzz'
    when num % 3 == 0
      result << 'Fizz'
    when num % 5 == 0
      result << 'Buzz'
    else result << num
    end
  end
  result
end

