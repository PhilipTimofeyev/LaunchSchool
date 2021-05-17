def lights(n)
  switch_hsh = 1.upto(n).with_object({}) {|switch, hsh| hsh[switch] = false}

  switch_hsh.each do |divisor,_| 
    switch_hsh.each {|switch, position| switch_hsh[switch] = !position if  switch % divisor == 0}
  end
  
  lights_on = switch_hsh.keys.select {|switch| switch if switch_hsh[switch] }
  lights_off = switch_hsh.keys.select {|switch| switch if !switch_hsh[switch] }
  
  puts "Lights #{lights_off[0..-2].join(', ')} and #{lights_off[-1]} are now off; 
#{lights_on[0..-2].join(', ')} and #{lights_on[-1]} are now on."
end

lights(5)