class Guy
  def initialize
    @height = 1
    @name = "jeff"
  end

  def grow
    self.height = height + 1
  end
  private
  
  def height=(num)
    @height = num
  end
  attr_accessor :name
  attr_reader :height
end
