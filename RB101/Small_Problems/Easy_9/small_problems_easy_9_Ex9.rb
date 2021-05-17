GRADE = {
  0...60 => 'F',
  60...70 => 'D',
  70...80 => 'C',
  80...90 => 'B',
  90..100 => 'A'
}

def get_grade(score1, score2, score3)
  average = (score1 + score2 + score3) / 3
  GRADE.select {|key, value| return value if key === average}
end 

get_grade(95, 90, 93) == "A"
get_grade(50, 50, 95) == "D"