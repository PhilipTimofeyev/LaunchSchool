def factors(number)
  divisor = number
  factors = []
  if number > 0
    while divisor != 0
      factors << number / divisor if number % divisor == 0
      divisor -= 1
    end
    p factors
  else puts "Must be greater than 0"
  end
end

# purpose of number % divisor checks to see if the divisor is a factor of the number, since if the remainder isn't zero, then it is not a factor.

# purpose of factors is to return the array that has been filled. 