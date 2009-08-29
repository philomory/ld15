module LD15
  class Terrain
    
    attr_reader :map, :x, :y
    def initialize(map,x,y)
      @map, @x, @y = map, x, y
    end
    
    def self.load_terrain
      %w{Dirt EmptySpace SolidWall}.each do |terrain|
        require "Terrain/#{terrain}"
      end
    end
    
  end
end