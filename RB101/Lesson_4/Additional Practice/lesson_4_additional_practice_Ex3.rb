ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.each do |key, age|
  age >= 100 ? ages.delete(key) : nil
end

ages