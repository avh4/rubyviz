# Calling methods with unusual names

class Example
  def method1
    self.something= 5
    side_effect!
    quality?
  end
  def something=
  end
  def side_effect!
  end
  def quality?
  end
end