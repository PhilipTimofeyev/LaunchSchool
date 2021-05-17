file = File.open("small_problems_medium_2_Ex1_pg84.txt")

sentences =  file.read.gsub(/\s+/, " ").split(/\.|\?|!/)

p longest_sentence =  (sentences.sort_by {|sentence| sentence.split(" ").count})[-1]
p longest_sentence.split(' ').count

