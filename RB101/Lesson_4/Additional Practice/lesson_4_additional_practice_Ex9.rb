words = "the flintstones rock"

def titalize(title)
  title.split.map! {|word| word.capitalize}.join(" ")
end

p titalize(words)