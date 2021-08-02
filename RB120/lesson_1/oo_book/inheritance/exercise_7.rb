class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student2)
    grade > student2.what_grade
  end

  protected

  attr_accessor :grade
  def what_grade
    grade
  end
end

bob = Student.new("Bob", 84)
joe = Student.new("Joe", 96)

puts "Well done!" if joe.better_grade_than?(bob)



