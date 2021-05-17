def swap_name(str)
  name = str.split
  "#{name[1]}, #{name[0]}"
end

swap_name('Joe Roberts') == 'Roberts, Joe'