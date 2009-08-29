class Grid
  def initialize(width,height)
    @width, @height = width, height
    @spaces = Array.new(@height) {Array.new(@width)}
  end
  def [](x,y)
    if x.in?
end