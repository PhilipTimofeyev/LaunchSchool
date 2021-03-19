{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# => [nil, bear] because it creates a new array for any truthy elements from the block. Keys are ignored. 
# nil is returned because if no conditions of an if statement evaluate to true, it returns nil.

