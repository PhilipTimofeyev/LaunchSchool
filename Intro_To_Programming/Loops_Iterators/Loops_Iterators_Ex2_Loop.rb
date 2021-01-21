input = ""

while input != "STOP" do
  puts "Gimme something"
  input = gets.chomp
  puts "I like #{input}, give me more."
end