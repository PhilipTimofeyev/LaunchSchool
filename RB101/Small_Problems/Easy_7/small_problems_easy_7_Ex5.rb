LOWERCASE = ('a'..'z').to_a

def staggered_case(words, first_upcase)
  first_upcase == false ? lastcase = true : lastcase = false

  lower = words.split.map(&:downcase).join(' ')
  lower.chars.map do |char|
    if lastcase == false
      lastcase = !lastcase
      char.upcase
    else  
    lastcase = !lastcase
    char
    end
  end
.join
end

staggered_case('I Love Launch School!', true) == 'I LoVe lAuNcH ScHoOl!'
staggered_case('ALL_CAPS', false) == 'AlL_CaPs'
staggered_case('ignore 77 the 444 numbers', true) == 'IgNoRe 77 ThE 444 NuMbErS'