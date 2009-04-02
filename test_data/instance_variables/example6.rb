# A class with a methods that read instance variables

class Example6
  def method1
    local = @var1
    @var2 = local
  end
  def method2
    @var2 = @var3
  end
end
