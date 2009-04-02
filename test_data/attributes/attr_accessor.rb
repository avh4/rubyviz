# A reference to a variables exposed with attr_accessor

class Example
  attr_accessor :var1
  attr_accessor :var2, :var3
  def method1
    self.var1= 11
    self.var2= 22
    self.var3= 33
  end
  def method2
    @var1 = 11
    @var2 = 22
    @var3 = 33
  end
  def method3
    puts var1
    puts var2
    puts var3
  end
  def method4
    puts @var1
    puts @var2
    puts @var3
  end
end