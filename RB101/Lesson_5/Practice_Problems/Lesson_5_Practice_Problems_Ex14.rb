hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

arr = []

hsh.each do |key, value|
    if hsh[key][:type] == 'fruit'
      arr << hsh[key][:colors].map(&:capitalize)
    else arr << hsh[key][:size].upcase
    end
end

arr