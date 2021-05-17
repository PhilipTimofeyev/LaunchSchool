LOWERCASE = ('a'..'z')
UPPERCASE = ('A'..'Z')

def letter_case_count(letters)
  counts = {lowercase: 0, uppercase: 0, neither: 0}

  letters.chars.each do |char|
    if LOWERCASE.cover?(char)
      counts[:lowercase] += 1
    elsif UPPERCASE.cover?(char)
      counts[:uppercase] += 1
    else
      counts[:neither] += 1
    end
  end

  counts
end

letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }