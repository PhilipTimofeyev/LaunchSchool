flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

hsh = Hash.new
flintstones.each_with_index do |name, index|
    hsh[name] = index
end