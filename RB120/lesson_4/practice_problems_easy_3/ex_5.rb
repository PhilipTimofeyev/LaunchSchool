class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
# tv.manufacturer # => no method error
p tv.model # => nil

p Television.manufacturer # => nil
p Television.model # => no method error