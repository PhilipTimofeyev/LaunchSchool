vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]


def count_occurances(vehicles)
  result = { }

  vehicles.each do |n|
    n = n.downcase
    
    if result.has_key?(n.downcase)
      result[n].push(vehicles.count(n))
    else
      result[n] = [n]
    end
    
  end

  result.each do |key, value|
      puts "#{key} => #{value.count}"
  end
end

count_occurances(vehicles)