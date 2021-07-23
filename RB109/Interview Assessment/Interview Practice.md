1. Count letters in string (9:05)

   1. ```ruby
      def letter_count(str)
        result = Hash.new(0)
      
        str.each_char {|char| result[char.to_sym] += 1}
      
        result.sort_by {|k, _| k}.to_h
      end
      ```

2. Find All Pairs (11:25)

   1. ```ruby
      def pairs(arr)
        ref_arr = arr.uniq
      
        count = 0
      
        ref_arr.each {|num| count += (arr.count(num) / 2)}
      
        count
      end
      ```

3. Return substring Instance Count (5:53)

   1. ```ruby
      def solution(full_text, search_text)
        full_text.scan(/#{search_text}/).count
      end
      ```

4. Alphabet Symmetry (16:45)

   1. ```ruby
      def solve(arr)
        arr.map { |word| word.each_char.with_index(1).count {|letter, idx| (letter.downcase.ord - 96) == idx} }
      end
      ```

5. Longest Vowel Train (9:14)

   1. ```ruby
      def solve(s)
        s.scan(/[aeiou]+/).max_by(&:length).length
      end 
      ```

6. Non Even Substrings (19:52)

   1. ```ruby
      def solve(s) 
        count = 0
      
        start_idx = 0
        end_idx = 0 
      
        loop do 
          loop do 
            count += 1 if s[start_idx..end_idx].to_i.odd?
            end_idx += 1
            break if end_idx == s.length
          end
      
          start_idx += 1
          end_idx = start_idx
          break if start_idx == s.length
        end
      
        count
      end
      ```

7. Substring Fun (11:10)

   1. ```ruby
      def nth_char(words)
        words.each_with_object('').with_index { |(word, result), idx| result << word[idx] }
      end

8. Repeated Substring (1:25:00) (28:29)

   1. ```ruby
      def f(s)
        1.upto(s.length).with_object([]) do |slice_size, result|
          arr = []
          s.chars.each_slice(slice_size) {|substring| arr << substring}
          return result = [arr.first.join, arr.size] if arr.all?(arr.first)
        end
      end
      ```
      
   2. ```ruby
      def f(str)
        substrings = []
      
        0.upto(str.length - 1) do |num|
          substrings << str[0..num]
        end
        
        result = nil
        idx = 0
      
        str.length.times do
          num = str.length / substrings[idx].length
          return result = [substrings[idx], num] if substrings[idx] * num == str
          idx += 1
        end
        result
      end
      ```

   3. 

9. Typoglycemia Generator (29: 43)

   1. ```ruby
      def scramble_words(words)
        return '' if words == ''
        words.split.map {|word| code_word(word)}.join(' ')
      end
      
      
      def code_word(word)
        alpha_chars = word.scan(/[a-zA-Z]/)
        first_letter = alpha_chars.first
        last_letter = alpha_chars.last
        alpha_chars_sorted  = alpha_chars[1..-2].sort
      
        alpha_coded_arr = [first_letter] + alpha_chars_sorted + [last_letter]
      
        result = word.chars
      
        result.each.with_index do |letter, idx|
          if letter.match?(/[a-zA-Z]/)
            result[idx] = alpha_coded_arr.shift
          end
        end
        result.join
      end
      ```

10. Most Frequently Used Words in a Text (33:37)

    1. ```ruby
       def top_3_words(text)
         split_str = text.split
         count_hsh = Hash.new(1)
       
         split_str.each do |word| 
           count_hsh[word.downcase.scan(/[a-zA-Z']/).join] += 1
         end
       
         count_hsh = count_hsh.select do |word, count| 
           word.match?(/[a-z']/) unless word.count("'") > 2 || word == "'"
         end
       
         sorted = count_hsh.sort_by { |word, count| count }
         if sorted.size > 2
           sorted[-3..-1].reverse.map {|word, count| word }
         elsif sorted.size == 2
           sorted[-2..-1].reverse.map {|word, count| word }
         else
           sorted.map {|word, count| word }
         end
       end
       ```

11. Extract Domain Name from URL (12:29)

    1. ```ruby
       def domain_name(url)
         result = url.include?("www") ? url.split('www.') : url.split('//')
         result.last.split('.').first
       end
       ```

12. Detect Pangram (5:49)

    1. ```ruby
       def pangram?(string)
         string.scan(/[a-zA-Z]/).map(&:downcase).uniq.count == 26
       end
       ```

13. Kebabize

    1. ```ruby
       def kebabize(str)
         result = str.chars.slice_when {|i, j| j.match?(/[A-Z]/) }.to_a.map(&:join).map(&:downcase)
         result = result.map {|word| word.scan(/[a-zA-Z]/).join}.join('-')
       
         if str[0].match(/[^a-zA-Z]/) && result[0] == '-'
           result[0] = ''
           result
         else
           result
         end
       end
       ```

14. Dubstep (4:42)

    1. ```ruby
       def song_decoder(song)
         song.gsub("WUB", " ").split.join(' ')
       end
       ```

15. Take a 10 minute walk (7:11)

    1. ```ruby
       def is_valid_walk(walk)
         return false if walk.size != 10
         walk.count('n') == walk.count('s') && walk.count('e') == walk.count('w')
       end
       ```

16. Stop gninnipS My sdroW! (11:17)

    1. ```ruby
       def spin_words(string)
         string.gsub(/\w{5,}/) {|word| word.reverse}
       end
       ```

17. Write Number in Expanded Form (17:53)

    1. ```ruby
       def expanded_form(num)
         result_arr = []
         quotient = num
       
         loop do
           zeroes = quotient.to_s.length - 1
           quotient, remainder = quotient.divmod(10 ** zeroes)
           result_arr << (quotient * (10 ** zeroes)).to_s
           break if remainder == 0
           quotient = remainder
         end
         result_arr.join(' + ')
       end
       ```

18. Persistence Bugger (6:14)

    1. ```ruby
       def persistence(n)
         count = 0
           until n < 10
             n = n.digits.reduce(&:*)
             count += 1
           end
           count
       end
       ```

19. Title Case (17:51)

    1. ```ruby
       def title_case(title, minor_words = '')
          title.split.map.with_index do |word, idx|
           if idx == 0
             word.capitalize
           elsif minor_words.downcase.split.any? {|minor| minor == word.downcase }
             word.downcase
           else
             word.capitalize
           end
         end.join(' ')
       end
       ```

20. Count and Group Character Occurances in String

    1. ```ruby
       def get_char_count string
         filtered_arr = string.downcase.scan(/[a-z0-9]/)
         result = Hash.new
       
         filtered_arr.each do |char|
           count = filtered_arr.count(char)
           if result.keys.include?(count) && result[count].none?(char)
             result[count] << char
           elsif result.keys.include?(count) && result[count].any?(char)
             next
           else
             result[count] = [char]
           end
           result[count].sort!
         end
       
         result
       end
       ```

21. Fine the Mine! (13:11)

    1. ```ruby
       def mineLocation field
         field.each_with_object([]).with_index do |(row, result), idx|
           row.each_with_index {|column, idx2| return result += [idx, idx2] if column == 1} 
         end
       end
       ```

22. Scamblies (11: 21)

    1. ```ruby
       def scramble(s1,s2)
         s2.each_char { |char|  return false if s1.count(char) < s2.count(char) }
         true
       end
       ```

23. Longest Alphabetical Substring (24:42)

    1. ```ruby
       def longest(s)
         sorted = s.chars.slice_when{|i, j| i > j }.to_a.sort_by(&:count)
         sorted.select {|arr| arr.count == sorted.last.count}.first.join
       end
       ```

24. The Hashtag Generator (13:42)

    1. ```ruby
       def generateHashtag(str)
         arr = str.split
         arr.empty? || arr.join.length > 139 ? false : '#' + arr.map {|word| word.capitalize}.join
       end
       ```

25. Pete, the Baker (15:56)

    1. ```ruby
       def cakes(recipe, available)
         return 0 if !(recipe.keys - available.keys).empty?
       
         return 0 if available.any? {|k, v| v < recipe[k] unless recipe[k].nil?}
       
         recipe.each_with_object([]) {|(k, v), arr| arr << available[k] / v}.min
       end

26. Mean Square Error (11:40)

    1. ```ruby
       def solution (arr1, arr2)
         differences_arr = []
         arr1.each.with_index {|num, idx| differences_arr << (num - arr2[idx]).abs} 
       
         differences_arr.reduce(0) {|sum, num| sum + num ** 2 } / arr1.size.to_f
       end
       ```

27. Exponent Method (10:49)

    1. ```ruby
         def power(base, exponent)
           return 1 if exponent == 0
           return nil if exponent < 0
           result = base
           (exponent - 1).times {p result *= base}
           result
         end
       ```

28. Where my anagrams at? (7:26)

    1. ```ruby
       def anagrams(word, words)
         words.select {|str| str.chars.sort == word.chars.sort }
       end
       ```

29. Split Strings (13:13)

    1. ```ruby
       def solution(str)
         result_arr = []
         working_str = ''
         
         str.each_char.with_index do |char, idx|
           working_str << char
           
           if idx.odd?
             result_arr += [working_str]
             working_str = ''
           end
         end
         
         result_arr << (working_str << '_') if str.length.odd?
         result_arr
       end
       ```

30. Anagram Difference (26:38) ***

    1. ```ruby
       def anagram_difference(a, b)
         first_word = a.chars.uniq
         second_word = b.chars.uniq
         
         total = 0
         
         first_word.each { |char| total += a.count(char) - b.count(char) if a.count(char) > b.count(char) }
         second_word.each { |char| total += b.count(char) - a.count(char) if b.count(char) > a.count(char) }
         
         total
       end
       ```

31. Anagram Detection (1:30)

    1. ```ruby
       def is_anagram(str1, str2)
         str1.downcase.chars.sort == str2.downcase.chars.sort
       end
       ```

32. Highest Scoring Word (15:53)

    1. ```ruby
       def high(str)
         score_hsh = {}
         
         str.split.each do |word|
           score = 0
           word.each_char { |char| score += (char.ord - 96) }
           score_hsh[word] = score
           score = 0
         end
         
         highest_value = score_hsh.sort_by { |k, v| v }.last.last
         score_hsh.select {|k, v| v == highest_value }.keys.first
       end
       ```

33. Replace With Alphabet Position (9:34) 

    1. ```ruby
       def alphabet_position(str)
         alpha_arr = str.downcase.scan(/[a-z]/)
         
         result = []
         alpha_arr.each {|char| result << (char.ord - 96).to_s }
         
         result.join(' ')
       end
       ```

34. Sherlock on Pockets (22:23)

    1. ```ruby
       def find_suspects(pockets, approved)
         return nil if pockets.all? {|_, v| v.nil? || v.empty?} || pockets.values.all? {|item| approved.include?(item)} || pockets.values.flatten.nil? || pockets.values.flatten.empty?
         return pockets.select{|k, v| v unless v.nil? || v.empty?}.keys if approved.nil? || approved.empty?
         result = pockets.select {|k, v| !v.all? {|item| approved.include?(item) } }.keys
         
         result.empty? ? nil : result
       end
       ```

35. Mexican Wave (28:26) ***

    1. ```ruby
       def wave(str)
         no_spaces = str.split.join
         no_spaces_arr = no_spaces.chars.map.with_index do |word, idx|
           new_word = no_spaces.dup
           new_word[idx] = new_word[idx].upcase
           new_word
         end
         
         no_spaces_arr.map.with_index do |word, idx|
           final_str = str.dup
           word_arr = word.chars
           str.chars.map.with_index do |letter, idx2| 
             final_str[idx2] != ' ' ? final_str[idx2] = word_arr.shift : ' '
           end.join
         end
       end
       ```

36. Delete a Digit (12:30)

    1. ```ruby
       def delete_digit(digit)
         result = []
         0.upto(digit.to_s.length - 1) do |num|
           string = digit.to_s
           string[num] = ''
           result << string.to_i
         end
         result.max
       end
       ```

37. Multiples of 3 or 5 (9:39)

    1. ```ruby
       def solution(num)
         (1...num).select {|i| i % 3 == 0 || i % 5 == 0 }.sum
       end
       ```

38. String Transformer

    1. ```ruby
       def string_transformer(str)
         result = []
         working_str = ''
       
         str.each_char.with_index do |char, idx|
           working_str << char
           next_char = idx + 1
           if str[next_char] != ' ' && char == ' '
             result += [working_str]
             working_str = ''
           elsif str[next_char] == ' ' && working_str[-1] != ' '
             result += [working_str]
             working_str = ''
           end
         end
         result += [working_str]
         result.reverse.map(&:swapcase).join
       end
       ```

    2. ```ruby
       def string_transformer(str)
         str.chars.slice_when {|i, j| i ==  ' ' || j == ' '}.to_a
         .reverse
         .map(&:join)
         .map(&:swapcase).join
       end
       ```

39. Largest Product in a Series (6:49)

    1. ```ruby
       def greatest_product(n)
         result = []
         n.chars.map(&:to_i).each_cons(5) {|five| result << five.reduce(&:*) }
         result.max
       end
       ```

    2. ```ruby
       def greatest_product(n)
         result = 0
         n.chars.each_cons(5) do |num|
           product = num.reduce {|product, digit| product.to_i * digit.to_i }
           result = product if product > result
         end
         result
       end
       ```

    3. ```ruby
       def greatest_product(n)
         result_arr = []
       
         start_idx = 0
         end_idx = 4
       
         loop do
           result_arr << n[start_idx..end_idx].chars.map(&:to_i)
           start_idx += 1
           end_idx += 1
           break if end_idx == n.length
         end
         result_arr.map {|a| a.reduce(&:*)}.max
       end
       ```

40. Duplicate Encode (8:42)

    1. ```ruby
       def duplicate_encode (str)
         str.downcase.each_char.with_object('') {|char, result| str.downcase.count(char) > 1 ? result << ')' : result << '('}
       end
       ```

    2. ```ruby
       word.downcase.each_char.with_object('') { |char, str| word.downcase.count(char) > 1 ? str << ')' : str << '(' }
       ```

41. Backspace in String

    1. ```ruby
       def clean_string(string)
         result = ''
       
         string.each_char do |char|
           if char != '#'
             result << char
           else
             result[-1] = '' unless result.empty?
           end
         end
         result
       end
       ```
       
    2. ```ruby
       (2 hours +)
       def clean_string(str)
         return str if str.count('#') == 0 
           to_delete = str.index('#')
           str[(to_delete - 1)..to_delete] = ''
           str[0] = '' if str[0] == '#'
         clean_string(str)
       end
       ```

42. Sorting Arrays

    1. ```ruby
       def sortme(strings)
         strings.sort_by {|word| word.downcase}
       end
       ```
       
    2. 1:20

       1. ```ruby
          def sortme(strings)
            strings.sort_by(&:downcase)
          end
          ```

43. Transform to Prime (2nd: 14:16)

    1. ```ruby
       def prime?(num)
         (2...num).to_a.none? {|n| num % n == 0}
       end
       
       def minimum_numbers(numbers)
         result = 0
         until prime?(total = numbers.sum + result)
           result += 1
         end
         result
       end
       ```
       
    2. ```ruby
       def minimum_number(arr)
         return 0 if is_prime?(arr.sum)
         count = 0
         sum = arr.sum
         
         loop do
           sum += 1
           count += 1
           break if is_prime?(sum)
         end
         count
           
       end
       
       def is_prime?(num)
         (2...num).to_a.none? {|i| num % i == 0 }
       end
       ```

    3. 

44. Counting Duplicates (2nd: 10:33)

    1. ```ruby
       def duplicate_count(str)
         str.downcase.chars.select {|char| str.downcase.count(char) > 1}.uniq.count
       end
       ```
       
    2. ```ruby
       def duplicate_count(str)
         lower_case = str.downcase
         no_dup = lower_case.chars.uniq
         
         count = 0
         no_dup.each {|char| count += 1 if lower_case.count(char) > 1 }
         
         count
       end
       ```

45. Alphabetized (5:30) (10:27)

    1. ```ruby
       def alphabetized(s)
         s.scan(/[a-zA-Z]/).sort_by(&:downcase).join
       end
       ```

    2. ```ruby
       def alphabetized(s)
         lower = ('a'..'z').to_a
         upper = ('A'..'Z').to_a
       
         result = []
         s.chars.each { |char| result << char if lower.include?(char) || upper.include?(char) }
         result.sort_by(&:downcase).join
       
       end
       ```

46. Sum of Digits / Digital Root (6:50) (4:50)

    1. ```ruby
       def digital_root(n)
         n = n.digits.sum until n < 10
         n
       end
       ```
       
    2. ```ruby
       def digital_root(num)
         return num if num < 10
         
         num = num.digits.sum
         digital_root(num)
       end
       ```

47. Array.digg

    1. ```ruby
       def array_diff(a, b)
         a.each.with_object([]) {|num, result| result << num unless b.include?(num)}
       end
       ```

    2. ```ruby
       def array_diff(a, b)
         a - b
       end
       ```

48. Where is my parent? (13:47) (15:09)

    1. ```ruby
       def find_children(dancing_brigade)
         dancing_brigade.chars.sort.each_with_object({}) do |char, hsh|
           char == char.upcase ? hsh[char] = [] : hsh[char.upcase] << char
         end
         .to_a
         .join
       end
       ```
       
    2. ```ruby
       def find_children(str)
         result_hsh = {}
         str.chars.sort.each do |char|
           if char.upcase == char
             result_hsh[char] = []
           else
             result_hsh[char.upcase] << char
           end
         end
         result_hsh.to_a.map(&:join).join
       end
       ```

49. Playing with Digits (11:03) (11:22)

    1. ```ruby
       def dig_pow(n, p)
         arr = n.to_s.chars.map(&:to_i)
         sum = 0
       
         arr.each.with_index(p) { |num, idx| sum += num ** idx }
         sum % n == 0 ? sum / n : -1
       end
       ```
       
    2. ```ruby
       def dig_pow(k, p)
         result = k.to_s.chars.map.with_index(p) {|i, idx| i.to_i ** idx }.sum
         result % k == 0 ? result / k : -1
       end
       ```

50. Equal Sides of an Array (25:02) (12:55)

    1. ```ruby
       def find_even_index(arr)
         return 0 if arr[1..-1].sum == 0
       
         slice_1_start = 0
         slice_1_end = 0
       
         result_idx = 1
       
         slice_2_start = 2
         slice_2_end = arr.size
       
         loop do
           break if arr[slice_1_start..slice_1_end].sum == arr[slice_2_start..slice_2_end].sum
           result_idx += 1
           slice_1_end += 1
           slice_2_start += 1
           return -1 if slice_2_start > arr.size
         
         end
         result_idx
       end
       ```
       
    2. ```ruby
       def find_even_index(arr)
         arr.each_with_index do |num, idx|
           break if (idx + 1).nil?
           idx == 0 ? left_sum = 0 : left_sum = arr[0...idx].sum
           right_sum = arr[idx + 1..-1].sum
           return idx if left_sum == right_sum
         end
         -1
       end

51. Reverse or Rotate? (21:17) (21:14)

    1. ```ruby
       def revrot(str, sz)
         return '' if sz <= 0 || sz > str.length
         chunks = str.chars.each_slice(sz).to_a
       
         result_arr = chunks.map { |sub| cube_even?(sub) ? sub.reverse : sub.rotate }
         
         str.length % sz == 0 ? result_arr.join : result_arr[0..-2].join
       end
       
       def cube_even?(chunk)
         chunk.map(&:to_i).reduce {|sum, num| sum + (num ** 3)}.even?
       end
       ```
       
    2. ```ruby
       def revrot(str, sz)
         return '' if sz <= 0 || str.empty? || sz > str.length
         chunks = str.chars.each_slice(sz).to_a.reject {|chunk| chunk.size < sz }
         
         chunks.map {|chunk| reverse?(chunk) ? chunk.reverse.join : chunk.rotate.join }.join
       end
       
       def reverse?(arr)
         arr.map(&:to_i).map {|i| i ** 3 }.sum % 2 == 0
       end
       ```

52. Decipher this! (50:06) (13:53 3rd one)

    1. ```ruby
       def decipher_this(string)
         num_decipher = string.gsub(/[0-9]+/) {|num| num.to_i.chr}
       
         num_decipher.split.each do |word|
           word[1], word[-1] = word[-1], word[1] if word.length > 1
         end
         .join(' ')
       end
       ```

    2. ```ruby
       def decipher_this(string)
         num_to_letter_str = decipher_num(string)
         letter_swap = letter_swap(num_to_letter_str)
       
         idx2 = -1
         num_to_letter_swap_arr = num_to_letter_str.chars
         num_to_letter_swap_arr.map.with_index do |char, idx|
           if char != ' '
             idx2 += 1
             letter_swap[idx2]
           else
             ' '
           end
         end.join
       end
       
       def decipher_num(str)
         num_to_letter_arr = []
         working_str = ''
       
         str.chars.each.with_index do |char, idx|
           working_str << char
       
           if working_str[-1].match?(/[0-9]/) && !str.chars[idx + 1].match?(/[0-9]/) && !str.chars[idx + 1].nil?
             num_to_letter_arr += [working_str.to_i.chr]
             working_str = ''
           elsif working_str[-1].match?(/[^0-9]/) && !str.chars[idx + 1].nil? && str.chars[idx + 1].match?(/[0-9]/)
             num_to_letter_arr += [working_str]
             working_str = ''
           end
         end
         num_to_letter_arr += [working_str]
         num_to_letter_str = num_to_letter_arr.join
       end
       
       def letter_swap(str)
         str.split.each do |word|
           word[1], word[-1] = word[-1], word[1] unless word.length < 2
         end.join
       end
       
       decipher_this('72olle 103doo 100ya') == "Hello good day"
       decipher_this("   65 119esi 111dl    111lw 108dvei 105n 97n 111ka  ") == "   A wise old    owl lived in an oak  "
       decipher_this('') == ''
       ```
       
       ```ruby
       def decipher_this(str)
         result = str.split.map do |word| 
           word.gsub!(/\d+/) {|num| num.to_i.chr }
           word[1], word[-1] = word[-1], word[1] if word.length > 2
           word
         end.join(" ")
       end
       ```
       
       

53. Bouncing Balls (29:04) (16:37)

    1. ```ruby
       def bouncingBall(h, bounce, window)
         return -1 if h <= 0 || window >= h || (bounce >= 1 || bounce <= 0)
       
         result = 0
         until h <= window
           h *= bounce
           result += 2
         end
         result - 1
       end
       ```
       
    2. ```ruby
       def bouncingBall(h, b, w)
         return -1 if h <= 0 || (b <= 0 || b >= 1) || w >= h
         
         count = 1
         loop do
           h *= b
           break if h <= w
           count += 2
         end
         count
       end
       ```

54. Weird Case (16:03) (12:19)

    1. ```ruby
       def weirdcase string
          string.split.map do |word|
           word.chars.map.with_index do |char, idx|
             if idx.even?
               char.upcase
             elsif idx.odd?
               char.downcase
             else
               char
             end
           end.join
         end.join(' ')
       end
       ```
       
    2. ```ruby
       def weirdcase(str)
         str.split.map do |word| 
           word.chars.map.with_index {|letter, idx| idx.even? ? letter.upcase : letter.downcase }.join
         end.join(" ")
       end
       ```

55. Are they the same? (8:19) (9:14)

    1. ```ruby
       def comp(array1, array2)
         array1.nil? || array2.nil? ? false : array1.map {|num| num ** 2}.sort == array2.sort
       end
       ```

    2. ```ruby
       def comp(arr1, arr2)
         return false if arr1.nil? || arr2.nil? 
         
         arr1.each {|el| return false if arr1.count(el) != arr2.count(el ** 2) }
         true
       end
       ```

56. Grouping and Counting (10:12) (5:55)

    1. ```ruby
       def group_and_count(input)
         return nil if input.nil? || input.empty?
         
         input.each.with_object({}) do |value, result|
           result.keys.include?(value) ? result[value] += 1 : result[value] = 1
         end
       end
       ```
       
    2. ```ruby
       def group_and_count(arr)
         return nil if arr.nil? || arr.empty?
         
         result = {}
         
         arr.uniq.each {|el| result[el] = 0 }
         arr.each {|el| result[el] += 1 }
         
         result
       end
       ```

57. Find the Nexus of the Codewars Universe (16:28) (11:49)

    1. ```ruby
       def nexus users
         result = users.each.with_object({}) { |(k, v), hsh| hsh[k] = (k - v).abs }.sort_by {|_, v| v}
         
         lowest_value = result.first.last
       
         result.select {|k, v| v == lowest_value}.sort.first.first
       end
       ```
       
    2. ```ruby
       def nexus(hsh)
         sorted = hsh.sort_by {|k, v| (k - v).abs }
         sorted.select {|k ,v| (k - v).abs == (sorted.first.first - sorted.first.last).abs }.to_h.keys.min
       end
       ```

58. Count Letters in String (5:54) (2:44)

    1. ```ruby
       def letter_count(str)
         str.each_char.with_object(Hash.new(0)) { |char, hsh| hsh[char.to_sym] += 1 }
       end
       ```
       
    2. ```ruby
       def letter_count(str)
         str.each_char.with_object(Hash.new(0)) {|char, result| result[char.to_sym] += 1 }.sort.to_h
       end
       ```

59. Triple Trouble (15:41) (14:06)

    1. ```ruby
       def triple_double(num1,num2)
         x = num1.to_s.scan(/(\d)\1+/)[0]
         unless x.nil?
           num2.to_s.scan(/(#{x})\1/).empty? ? 0 : 1
         else
           0
         end
       end
       ```

    2. ```ruby
       def triple_double(num1,num2)
           first = num1.to_s.chars.slice_when { |i, j| i != j}.to_a.select {|arr| arr.count >= 3}.flatten
           second = num2.to_s.chars.slice_when { |i, j| i != j}.to_a.select {|arr| arr.count >= 2}.flatten
       
           first.any? {|num| second.any?(num)} ? 1 : 0
       end
       ```
       
    3. ```ruby
       def triple_double(num1, num2)
         num1.to_s.chars.uniq.each { |i| return 1 if num1.to_s.include?(i * 3) && num2.to_s.include?(i * 2) }
         0
       end

60. Which are in (15:31)

    1. ```ruby
       def in_array(array1, array2)
         array1.select { |arr| array2.any? { |word| word.match?(/#{arr}/) } }.sort
       end
       ```

61. Format a string of names (22:40)

    1. ```ruby
       def list names
         names_list = names.map {|k, v| k.values}.flatten
         
         case names.size
         when 4..Float::INFINITY
           "#{names_list[0..-3].join(', ')}, #{names_list[-2..-1].join(' & ')}"
         when 3
           "#{names_list[0]}, #{names_list[1]} & #{names_list.last}"
         when 2
           "#{names_list.first} & #{names_list.last}"
         when 1
           "#{names_list[0]}"
         else
           ''
         end
       end
       ```

62. Find the missing letter (19:25) (6:06)

    1. ```ruby
       def find_missing_letter(arr)
         arr[0].downcase == arr[0] ? alpha = ('a'..'z').to_a : alpha = ('A'..'Z').to_a
       
         start_idx = alpha.index(arr[0])
         end_idx = alpha.index(arr[-1])
       
         given = alpha.slice(start_idx..end_idx)
       
         (given - arr).first
       end
       ```

    2. ```ruby
       def find_missing_letter(arr)
         arr.first.match(/[a-z]/) ? alpha = ('a'..'z').to_a : alpha = ('A'..'Z').to_a
         (alpha.grep(/[#{arr.first}-#{arr.last}]/) - arr).first
       end
       ```
       
    3. ```ruby
       def find_missing_letter(arr)
         arr.each.with_index {|char, idx| return char.next if char.next != arr[idx + 1] } 
       end
       ```

63. Who likes it (10:23)

    1. ```ruby
       def likes(names)
         case names.size
         when 0
           "no one likes this"
         when 1
           "#{names.first} likes this"
         when 2
           "#{names.first} and #{names.last} like this"
         when 3
           "#{names.first}, #{names[1]} and #{names.last} like this"
         when 4..Float::INFINITY
           "#{names.first}, #{names[1]} and #{names.size - 2} others like this"
         end
       end
       ```

64. Find the parity outlier (5:16) (4:35)

    1. ```ruby
       def find_outlier(integers)
         integers.count(&:even?) > 1 ? integers.select(&:odd?).first : integers.select(&:even?).first
       end
       ```
       
    2. ```ruby
       def find_outlier(arr)
         arr.count(&:odd?) > 1 ? arr.select(&:even?).first : arr.select(&:odd?).first
       end
       ```

65. Is integer Array (15:22) (8:20)

    1. ```ruby
       def is_int_array(arr)
         return false if arr.nil? || !arr.is_a?(Array) || arr.any?(&:nil?)
         arr.empty? || arr.all? { |num| num.is_a?(Integer) || num.is_a?(Float) && num.to_i == num }
       end
       ```
       
    2. ```ruby
       def is_int_array(arr)
         return false if arr.nil? || !arr.is_a?(Array)
         return true if arr.all? {|el| el.is_a?(Integer) || el.to_i == el } || arr.empty?
         false
       end
       ```

66. Basics 06: Reversing and Combining Text (2nd, 12:45)

    1. ```ruby
       def reverse_and_combine_text(s)
         result = s.split
       
         until result.size < 2
           result = result.map(&:reverse)
           
           previous_size = result.size
           last_element = result.last
           
           result = result.each.with_object([]).with_index { |(word, arr), idx| arr << (result[idx - 1] + word) if idx.odd?}
           result += [last_element] if previous_size.odd?
         end
         
         result.join
       end
       ```
       
    2. ```ruby
       def reverse_and_combine_text(str)
         return str if str.split.size == 1
         result = str.split
         
         loop do
           result = result.map(&:reverse)
           result = result.each_slice(2).to_a.map(&:join)
           break if result.size == 1
         end
         result.first
       end 
       ```

67. Integer Reduction (Hour +) (Hour +)

    1. ```ruby
       def solve(n,k)
         combo = n.to_s.length - k
         n.to_s.chars.combination(combo).to_a.sort_by {|arr| arr.join.to_i}.first.join
       end
       ```
       
    2. ```ruby
       def solve(n, k)
         k.times { n = find_smaller(n) }
         n
       end
       
       def find_smaller(num)
         num_arr = num.to_s.chars
         num_arr.each_index.with_object([]) do |idx, arr|
           working = num_arr.dup
           working.delete_at(idx)
           arr << working.join
         end.min_by(&:to_i)
       end
       ```

68. Divisible Sum Pairs (15:23)

    1. ```ruby
       def divisibleSumPairs(arr, k)
         combos = arr.combination(2).to_a
         combos.select do |combo|
           combo.sum % k == 0
         end.count
       end
       ```
       
    2. ```ruby
       def divisible_sum_pairs(arr, k)
         result = []
         
         arr.each.with_index do |num1, idx1|
           arr.each.with_index do |num2, idx2|
             result << [num1, num2].sum if idx2 > idx1
           end
         end
         result.count {|num| num % k == 0 }
       end
       ```

69. Roman Numeral (39:05)

    1. ```ruby
       def int_to_roman(num)
         roman_hsh = {'M': 1000, "D": 500, "C":100, "L": 50, "X": 10, "V": 5, "I": 1}
         result = ''
       
         roman_hsh.each do |letter, rom_num|
           quotient, remainder = num.divmod(rom_num)
           if letter == :C && quotient == 4
             result << 'CD'
           elsif letter == :X && quotient == 4
             result << 'XL'
           elsif letter == :I && quotient == 4
             result << "IV"
           else
             result << letter.to_s * quotient
           end
           num = remainder
         end
         result.gsub!('LXL', 'XC')
         result.gsub!('VIV', 'IX')
         result.gsub('DCD', 'CM')
       end
       ```

70. English Beggers *** (46:43) (28:32 2nd)

    1. ```ruby
       def beggars(values, n)
         return [] if n == 0
         
         idx = 0
         values_dup = values.dup
         
         result = []
         
         loop do
           earnings = []
           loop do
             earnings << values_dup[idx] if idx % n == 0
             idx += 1
             if idx >= values_dup.size
               break
             end
           end
           earnings.any?(nil) ? result << 0 : result << earnings.sum
           idx = 0
           values_dup.shift
           return result if result.count == n
         end
       end
       ```

    2. ```ruby
       def beggars(values, n)
         return [] if n == 0
         result = 0.upto(values.size).with_object([]) do |num, result|
           result << values[num..values.size].each.with_object([]).with_index {|(el, earnings), idx| earnings << el if idx % n == 0 }.sum
           return result if num == n - 1
         end
         (n - values.size - 1).times {result << 0}
         result
       end
       ```

71. Fold an Array (1:06:41) (15:00 3rd one)

    1. ```ruby
       def fold_array(arr, folds)
         return arr if arr.size == 1
         result = arr
         folds.times do 
           result = fold_once(result)
         end
         result
       end
       
       def fold_once(arr)
         result = []
         middle = arr.size / 2
         to_iterate = arr[0..middle]
         to_iterate.each.with_index(1) do |num, idx|
           result << num + arr[-idx] unless idx == to_iterate.size
         end
         result << to_iterate.last if arr.size.odd?
         result
       end
       ```

    2. ```ruby
       def fold_array(arr, folds)
         return arr if arr.size == 1
         folds.times { arr = fold_once(arr) }
         arr
       end
       
       def fold_once(arr)
         result = []
         middle = arr.size / 2
         arr.each.with_index(1) do |num, idx|
           break if idx == middle + 1
           result << num + arr[-idx] 
         end
         arr.size.odd? ? result << arr[middle] : result
       end
       ```

    3. ```ruby
       def fold_array(arr, n)
         n.times do
           half = arr.size / 2
       
           first_half =  arr[0...half]
           second_half = arr[half..-1].reverse
       
           arr = second_half.zip(first_half).map {|fold| fold - [nil]}.map(&:sum)
         end
         arr
       end   
       ```

    4. 

72. Your order please 6kyu (5:47)

    1. ```ruby
       def order(str)
         str.split.sort_by {|word| word.scan(/[1-9]/).join}.join(' ')
       end
       ```

73. Tribonacci Sequence 6kyu (16:31)

    1. ```ruby
       def tribonacci(arr, n)
         return arr[0...n] if n < 3
         arr.each_with_index do |num, idx|
           return arr if idx == n - 3
           arr.push(num + arr[idx + 1] + arr[idx + 2])
         end
       end
       ```

74. Vasya-Clerk (50:26) ***

    1. ```ruby
       def tickets(arr)
         count = {
           25 => 0,
           50 => 0,
           100 => 0
         }
       
         arr.each do |num|
           case num
           when 25
             count[25] += 1
           when 50
             count[25] -= 1
             count[50] += 1
           when 100
             count[100] += 1
             if count[50] >= 1
               count[50] -= 1 
               count[25] -= 1
             else
              count[25] -= 3
             end
           end
           return 'NO' if count.any?{|k, v| v < 0}
         end
         'YES'
       end
       ```

75. Convert String to Camel Case 6kyu (9:54)

    1. ```ruby
       def to_camel_case(str)
         str.split(/[_-]/).map.with_index { |word, idx| idx == 0 && str.capitalize != str ? word : word.capitalize }.join
       end
       ```

76. Consecutive Strings 6kyu (17:02)

    1. ```ruby
       def longest_consec(arr, k)
         return "" if arr.empty? || k > arr.size || k <= 0
       
         result = []
         arr.each_cons(k) { |words| result << words.join }
         
         largest = result.max_by(&:length).length
         result.select {|words| words.length == largest}.first
       end
       ```

77. Find the unique number 6ku (8:40)

    1. ```ruby
       def find_uniq(arr)
         arr.each {|num| return (arr - [num]).first if arr.count(num) > 1}
       end
       ```

78. Find longest substring 'a' and 'e' (8:46 2nd attempt)

    1. ```ruby
       # Find the length of the longest substring in the given string that contains exatly 2 characters "a" and 2 characters "e" in it.
       
       # As an example, if the input was “aaee”, the substring (aaee) length would be 4.
       # For a string "babanctekeaa", the longest substring is "babancteke" and its length is 10.
       
       # If the length of the input string is 0, return value must be -1 and if none of the substrings contain 2 "a" and "e" characters return -1 as well.
       
       p longest_ae("aaee") == 4
       p longest_ae("babanctekeaa") == 10
       p longest_ae("xenoglossophobia") == -1
       p longest_ae("pteromerhanophobia") == 18
       p longest_ae("johannisberger") == -1
       p longest_ae("secaundogenituareabb") == 16
       ```

    2. ```ruby
       def longest_ae(str)
         arr = []
         0.upto(str.size - 4) do |start_idx|
           (start_idx + 3).upto(str.size - 1) do |end_idx|
             arr << str[start_idx..end_idx]
           end
         end
         result = arr.select {|word| word.count('e') == 2 && word.count('a') == 2}.max_by(&:length)
         result.nil? ? -1 : result.length
       end
       ```

    3. ```ruby
       def longest_ae(str)
         return -1 if str.empty?
         
         substrings = []
       
         4.upto(str.length) do |slice_size|
           str.chars.each_cons(slice_size) { |slice| substrings << slice.join if slice.count('a') == 2 && slice.count('e') == 2 }
         end
       
         substrings.empty? ? -1 : substrings.max_by(&:length).length
       end
       ```

79. 3rd maximum

    1. ```ruby
       # Given integer array nums, return the third maximum number in this array. If the third maximum does not exist, return the maximum number.
       # You are not allowed to sort the array
       
       p third_max([3,2,1]) == 1
       p third_max([1,2]) == 2
       p third_max([2,2,3,1]) == 1
       p third_max([1, 3, 4, 2, 2, 5, 6]) == 4
       ```

    2. ```ruby
       def third_max(arr)
         return find_greatest(arr) if arr.size < 3
         result = 0
         3.times do
           result = find_greatest(arr)
           arr.delete(result)
         end
         result
       end
       
       def find_greatest(arr)
         greatest = 0
       
         arr.each {|num| greatest = num if num > greatest}
         greatest
       end
       ```

80. Sum of Same and consecutive integers

    1. ```ruby
       # You are given an array which contains only integers (positive and negative). Your job is to sum only the numbers that are the same and consecutive. The result should be one array.
       
       # You can assume there is never an empty array and there will always be an integer.
       
       p sum_consecutives([1,4,4,4,0,4,3,3,1, 1]) == [1,12,0,4,6,2]
       p sum_consecutives([1,1,7,7,3]) == [2,14,3]
       p sum_consecutives([-5,-5,7,7,12,0]) ==  [-10,14,12,0]
       ```

    2. ```ruby
       def sum_consecutives(arr)
         arr.slice_when{|i, j| i != j}.to_a.map(&:sum)
       end
       ```

    3. ```ruby
       def sum_consecutives(arr)
         result = []
       
         working_arr = []
       
         arr.each.with_object([]) do |num, sub_arr|
           if working_arr.empty? || working_arr.last == num
             working_arr += [num]
           else 
             result += [working_arr]
             working_arr = []
             working_arr += [num]
           end
         end
         result += [working_arr]
         result.map(&:sum)
       end
       ```

    4. ```ruby
       def sum_consecutives(arr)
         result = []
       
         arr.each.with_index do |num, idx|
           if idx == 0
             result << num
           else
             if arr[idx - 1] == num 
               result[-1] += num 
             else 
               result << num
             end
           end
         end
         result
       end
       ```

81. Simple Pig Latin 5kyu (11:15)

    1. ```ruby
       def pig_it(str)
         str.gsub(/[a-zA-Z]+/) do |word|
           first_letter = word[0]
           word[0] = ''
           word << first_letter + "ay"
         end
       end
       ```

82. Simple Simple Simple String Expansion 6kyu (Hour+) (27:13 2nd Attempt)

    1. ```ruby
       def string_expansion(str)
         return str if str.scan(/[0-9]/).size == 0
         result = str.gsub(/[0-9]+/) {|num| num[-1]}
          
         until result[-1].to_i.to_s != result[-1]
           result[-1] = ''
         end
         result = result.chars.slice_when {|i, j| j.match?(/[0-9]/)}.to_a
       
         result.map do |sub|
           if sub.size > 2 && sub.join.match?(/[0-9]/)
             sub[1..-1].each.with_object('') { |char, str| str << char * sub[0].to_i }
           elsif sub.join.match?(/[0-9]/)
             sub.last * sub.first.to_i
           else
             sub
           end
         end.join
       end
       ```

    2. ```ruby
       def string_expansion(str)
         return str if !str.match?(/[0-9]/)
       
         single_digit_str = ''
         str.each_char.with_index do |char, idx|
           unless char.match?(/[0-9]/) && !str[idx + 1].nil? &&  str[idx + 1].match?(/[0-9]/)
             single_digit_str << char
           end
         end
       
         result_arr = single_digit_str.chars.slice_when { |i, j| j.match?(/[0-9]/) }.to_a
         
         result_arr.each.with_object('') do |arr, result|
           if arr.first.match?(/[0-9]/)
             digit = arr.first.to_i
             arr[1..-1].each { |char| result << char * digit }
           else
             result << arr.join
           end
         end
       end
       ```

83. Sum of Pairs 5kyu (Times out)

    1. ```ruby
       def sum_pairs(ints, s)
         result = []
         smallest_idx = Float::INFINITY
         checked_nums = []
       
         ints.each.with_index do |num, idx|
           next if checked_nums.include?(num)
           checked_nums << num
           
           num2 = s - num
           
           unless ints[idx + 1..-1].index(num2).nil? 
             num2_idx = ints.rindex(num2)
             result = [num, num2] if num2_idx < smallest_idx
             smallest_idx = num2_idx if num2_idx < smallest_idx
           end
         end
         result.empty? ? nil : result
       end
       ```

84. Battleships (38:27)

    1. ```ruby
       def damaged_or_sunk (board, attacks)
         boat_hsh = {}
       
         1.upto(4) { |num| boat_hsh[num] = board.flatten.count(num) }
       
         boat_hsh_orig = boat_hsh.dup
       
         formatted_attacks = attacks.map { |arr| [-arr.last, arr.first - 1] }
       
         formatted_attacks.each do |arr|
           hit = board[arr.first][arr.last]
           boat_hsh[hit] -= 1 if hit > 0 && boat_hsh[hit] > 0
         end
       
         result_hsh = {'sunk'=> 0, 'damaged' => 0, 'not_touched' => 0, 'points' => 0}
       
         boat_hsh.each do |k, v|
           if v > 0 && v < boat_hsh_orig[k]
             result_hsh['damaged'] += 1
           elsif v == 0 && v != boat_hsh_orig[k]
             result_hsh['sunk'] += 1
           elsif v == boat_hsh_orig[k] && boat_hsh_orig[k] != 0
             result_hsh['not_touched'] += 1
           end
         end
         result_hsh['points'] = (result_hsh['sunk'] * 1) + (result_hsh['damaged'] * 0.5) - (result_hsh['not_touched'] * 1)
       
         result_hsh
       end
       ```

85. 

