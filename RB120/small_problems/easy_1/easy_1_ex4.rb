class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# It depends on the context of the class, but initializing is important since it initializes the instance variables and their initial values at the instantiation of a class instance. 
# The problems could be if we need a starting value that doesn't need to be added as an argument when created the object, there is no way to do this without the initializing method.