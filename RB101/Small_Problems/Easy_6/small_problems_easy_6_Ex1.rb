DEGREE = "\xC2\xB0"

def dms(float)
  case float <=> 0
  when -1
    until float >= 0
      float += 360
    end
    float
  when 0
    float
  when 1
    until float <= 360
      float -= 360
    end
    float
  end


  degrees, minutes_dec = float.divmod(1)
  minutes = (minutes_dec * 60)
  minutes, seconds_dec = minutes.divmod(1)
  seconds = (seconds_dec * 60).floor(0)

  minutes = format('%02d', minutes)
  seconds = format('%02d', seconds)
  %(#{degrees}#{DEGREE}#{minutes}'#{seconds}")
end

dms(30) == %(30°00'00")
dms(76.73) == %(76°43'48")
dms(254.6) == %(254°36'00")
dms(93.034773) == %(93°02'05")
dms(0) == %(0°00'00")
dms(360) == %(360°00'00") || dms(360) == %(0°00'00")