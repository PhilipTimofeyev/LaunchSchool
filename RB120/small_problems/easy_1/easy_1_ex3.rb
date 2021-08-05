class Book
  attr_reader :title, :author

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)


#The differences between reader, writer, and accessor is that reader creates an instance variable and a getter method, writer creates an instance variable and a setter method, 
#and accessor creates an instance variable and both a getter and setter. We use attr_reader because we only need to retrieve the instance variable, and not modify it. 
# We could have used accessor but not only writer.

# adding these will not change the behavior of the class because they are the getter methods which is what attr_reader does. An advantage is if we needed to modify the code as we get it. 

