['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

# takes the first letter of every value and makes it the hash. Returns a hash with {'a' => 'ant', 'b' => 'bear', 'c' = > 'cat'}