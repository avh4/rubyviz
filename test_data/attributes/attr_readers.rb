# A reference to a variable exposed with attr_reader with multiple arguments

class Example
  attr_reader :var1, :var2
  def method1
    puts var1
    puts var2
  end
  def method2
    puts @var1
    puts @var2
  end
end