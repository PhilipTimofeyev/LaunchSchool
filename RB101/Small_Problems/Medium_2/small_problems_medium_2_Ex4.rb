def balanced?(str)
  count = 0
  balanced = true
  str.chars.each do |char|
   count -= 1 if char == ')'
   balanced = false if count < 0
   count += 1 if char == '('
  end
  balanced
end


balanced?('What (is) this?') == true
balanced?('What is) this?') == false
balanced?('What (is this?') == false
balanced?('((What) (is this))?') == true
balanced?('((What)) (is this))?') == false
balanced?('Hey!') == true
balanced?(')Hey!(') == false
balanced?('What ((is))) up(') == false