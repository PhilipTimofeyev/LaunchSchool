ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

munsters_age = 0

ages.each do |_, age|
  munsters_age += age
end

munsters_age