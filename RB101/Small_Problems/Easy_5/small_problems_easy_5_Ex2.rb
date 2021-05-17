def time_of_day(minutes)
  if minutes >= 1440
    until minutes < 1440
       minutes -= 1440
    end
  elsif minutes <= -1440
  until minutes > -1440
       minutes += 1440
  end
  minutes
  end
  case minutes <=> 0
  when -1
    case 
    when (-50..0) === minutes
     (1440 + minutes).divmod(60).join(':')
    when (-59...-51) === minutes
     number, remainder = (1440 + minutes).divmod(60)
     "#{number}:0#{remainder}"
    when (-1439...-60) === minutes
      (1440 + minutes).divmod(60).join(':')
    end
  when 1
    case
      when (1..9) === minutes
       '00:0' + minutes.to_s
      when (10...60) === minutes
       '00:' + minutes.to_s 
      when (61...600) === minutes
       number, remainder = (minutes).divmod(60)
      "0#{number}:#{remainder}"
      when (601...1440) === minutes
       number, remainder = (minutes).divmod(60)
      "#{number}:#{remainder}"
    end
  when 0
    '00:00'
  end
end