require 'helper'

require 'Grid'
require 'Terrain'
LD15::Terrain.load_terrain
require 'Units'

module LD15
  class Map
    attr_reader :width, :height
    def initialize()
      @terrain = Grid.new()
      @units   = Grid.new()
    end
    def terrain_at(x,y)
      if x.in?(0...@width) and y.in?(0...@height)
        @terrain[x,y]
      else
        OutOfBounds.new
      end
    end
    
    def unit_at(x,y)
      if x.in?(0...@width) and y.in?(0...@height)
        @units[x,y]
      else
        OutOfBounds.new
      end
    end
  end
end