# Using variables in various ways with method calls

class Example
  def handle_ticket_show
    @var1.to_s
    puts @var2 + @var3
    @var4.find(@var5, @var6)
  end
end
