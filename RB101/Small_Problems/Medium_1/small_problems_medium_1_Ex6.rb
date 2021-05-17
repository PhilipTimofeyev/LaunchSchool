def minilang(cmd)
  register = 0
  stack = [ ]

  cmd.split.each do |el|
    case
      when el.match(/\d/)
        register = el.to_i
      when el == 'PUSH'
        stack << register  
      when el == 'ADD'
        register += stack.pop
      when el == 'SUB'
        register -= stack.pop
      when el == 'MULT'
        register *= stack.pop
      when el == 'DIV'
        register /= stack.pop
      when el == 'MOD'
        register %= stack.pop
      when el == 'POP'
        register = stack.pop
      when el == 'PRINT'
        p register
    end
  end
end

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')