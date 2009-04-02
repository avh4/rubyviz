# Various method calls

class Example1
  def center
  end
  def method1
    center
  end
  def method2
    center "a", "b"
  end
  def method3
    if "." == nil
      center
    end
  end
  def method4
    puts center
  end
  def method5
    5 + center
  end
  def method6
    self.center
  end
end