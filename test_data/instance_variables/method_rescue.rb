# A method containing variables inside a rescue block

class Example
 def initialize(args)
    @var1 = 234
  rescue Error1
    @var2 = 483
  end
end
