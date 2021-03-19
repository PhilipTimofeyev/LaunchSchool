munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, hsh|
  munsters[hsh.store('age_group', nil)]
  hsh.each do |k, v|
    case
    when (0..18) === hsh['age'] 
      hsh['age_group'] = 'kid'
    when (18..64) === hsh['age'] 
      hsh['age_group'] = 'adult'
    when hsh['age'] >= 65
      hsh['age_group'] = 'senior'
    end
  end
end

munsters