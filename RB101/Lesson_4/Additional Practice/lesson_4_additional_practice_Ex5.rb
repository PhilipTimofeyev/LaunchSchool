flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each_with_index {|name, index| puts index if name.start_with?("Be")}