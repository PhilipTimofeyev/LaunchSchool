x = [nil, nil, 3, nil, 4, nil]

y = nil

x.each do |el|
  y ||= el
end

p y