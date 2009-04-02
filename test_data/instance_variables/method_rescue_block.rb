# A method containing variables inside a rescue block with multiple statements

class Example
  def initialize(args)
    @var1 = 234
    @var2 = 234
  rescue Error1
    @var3 = 483
    @var4 = 234
  end
end
