# A reference to a variables exposed with attr_writer

class Example
  attr_writer :var1
  attr_writer :var2, :var3
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
end