class Banner

  def initialize(message, width = 50)
    @message = message
    @width = width

    begin
      if @message.length >= @width - 1
        raise 'Too narrow. Please increase.'
      end

    rescue => e
      puts e
      p e
      exit 1
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end


  private

  def horizontal_rule
    "+" + "-" * (@width) + "+" 
  end

  def empty_line
    "|" + " " * (@width) + "|"
  end

  def message_line
    "| #{@message.center(@width - 2)} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 44)
puts banner

banner = Banner.new('', 2)
puts banner