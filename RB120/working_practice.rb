 CHOICES_HSH = {
    rock: ['r', 'rock'],
    scissors: ['s', 'scissors'],
    paper: ['p', 'paper'],
    spock: ['sp', 'spock'],
    lizard: ['l', 'lizard']
  }

  p CHOICES_HSH.select {|_, v| v.include?('rock') }.keys.first