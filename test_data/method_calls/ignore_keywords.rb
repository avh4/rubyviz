# Ignore various method calls that are keywords

class Example
  def method1
    puts "string"
    require "yaml"
    system "xxx"
    `echo`
    raise "Message"
    exit 1
  end
end