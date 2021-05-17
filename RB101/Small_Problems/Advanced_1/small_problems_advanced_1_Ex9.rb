@result = [ ]
@den = 1

def egyptian(n)
  return @result if n == 0

  if Rational(1, @den) <= n
    n -= Rational(1, @den)
    @result << @den
  end

  @den += 1
  return egyptian(n)
end

def unegyptian(dens)
  dens.inject(Rational(0)) {|sum, den| sum + Rational(1, den)}
end
