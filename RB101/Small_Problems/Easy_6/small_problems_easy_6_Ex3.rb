@cache = [0,1]
def fib(n)
  return @cache[n] if @cache[n]
  @cache[n] = fib(n-1) + fib(n-2)
end

def find_fibonacci_index_by_length(num)
 index = 0
 index += 1 until (fib(index)).to_s.size >= num 
    
 return index
end

####### Or #####

def fib(n)
  (0..n).each_with_object([]) do |i, memo|
    memo[i] = i < 2 ? i : memo[i-1] + memo[i-2]
  end
end

def find_fibonacci_index_by_length(num)
 index = 0
  until (fib(index)).to_s.size >= num 
    index += 1
  end
  index
end