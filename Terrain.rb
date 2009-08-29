module LD15
  class Terrain
    
    attr_reader :x, :y
    def initialize(x,y)
      @x, @y = x, y
    end
    
    def load_terrain
      %w{Dirt EmptySpace SolidWall OutOfBounds}.each do |terrain|
        require "Terrain/#{terrain}"
      end
    end
    
  end
end