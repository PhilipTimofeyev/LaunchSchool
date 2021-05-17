def after_midnight(str)
  time_arr = str.split(':').map(&:to_i)
  time = (time_arr[0] * 60) + time_arr[1]
  time == 1440 ? 0 : time
end

def before_midnight(str)
  time_arr = str.split(':').map(&:to_i)
  1440 - ((time_arr[0] * 60) + time_arr[1])
end

###### Further ######

require 'time'

def after_midnight(str)
  t = Time.parse(str)
  (t.hour * 60 + t.min) % 1440
end

def before_midnight(str)
  t = Time.parse(str)
  1440 - (t.hour * 60 + t.min)
end