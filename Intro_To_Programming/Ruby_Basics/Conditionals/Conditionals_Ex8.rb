status = ['awake', 'tired'].sample

if status == 'awake'
  "Be productive"
  action = "Be productive!"
else
  "Go to sleep!"
  action = "Go to sleep!"
end

puts action
