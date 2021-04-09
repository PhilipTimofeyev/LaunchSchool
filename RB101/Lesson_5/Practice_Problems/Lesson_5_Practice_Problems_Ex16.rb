def generate_hex
  uuid = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
  charset = Array(0..9) + Array('a'..'f')
  uuid.chars.each_with_index do  | char, index |
    uuid[index] = charset.sample.to_s unless char == '-'
  end
uuid
end

generate_hex