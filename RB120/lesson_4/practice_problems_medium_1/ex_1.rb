class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

#Ben is right because balance on line 9 is a method returning the @balance instance variable, therefore it does not need an @.