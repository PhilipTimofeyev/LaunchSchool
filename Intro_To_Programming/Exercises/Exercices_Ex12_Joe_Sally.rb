contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"], ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts.each do |k, v|
    first_name = (k.split(" ")[0]).downcase
    
    contact_data.each do |n|
        n.each do |data|
            if data.include?(first_name)
                contacts[k] = {email: n[0], address: n[1], number: n[2]}
            end
        end
    end
end

puts contacts["Joe Smith"][:email]
puts contacts["Sally Johnson"][:number]