def letter_percentages(str)
  percent_hsh = {}
  total_char = str.length.to_f / 100
  char_arr = str.chars

  percent_hsh[:lowercase] = (char_arr.grep(/[a-z]/).count / total_char).round(2)
  percent_hsh[:uppercase] = (char_arr.grep(/[A-Z]/).count / total_char).round(2)
  percent_hsh[:neither] = (char_arr.grep(/[^a-zA-Z]/).count / total_char).round(2)

  percent_hsh
end

letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither: 25 }
letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }