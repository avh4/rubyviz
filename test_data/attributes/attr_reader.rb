# A reference to a variable exposed with attr_reader

class Example
  attr_reader :var1
  def method1
    puts var1
  end
  def method2
    puts @var1
  end
end