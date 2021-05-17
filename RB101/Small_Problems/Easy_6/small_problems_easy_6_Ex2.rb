VOWELS = %w(a e i o u A E I O U)

def remove_vowels(arr)
  arr.map do |el|
    (el.chars.delete_if {|letter| VOWELS.include?(letter)}).join
  end
end

remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']