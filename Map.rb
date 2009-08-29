require 'helper'

require 'Grid'
require 'Terrain'
LD15::Terrain.load_terrain
require 'Units'

module LD15
  class Map
    attr_reader :width, :height
    def initialize(level)
      terrain_array = load_data(level)
      @terrain = Grid.from_array(terrain_array)
      @width, @height = @terrain.width, @terrain.height
      @units   = Grid.new(@width,@height)
    end
    
    def load_data(path)
      file = File.open(path,'r')
      data = file.read
      file.close
      return data.split("\n").map {|row| row.split('')}.transpose
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
    
    def each
      @terrain.each_with_coords |terrain,x,y| do
        yield terrain, @units[x,y]
      end
    end
    
    def each_with_coords
      @terrain.each_with_coords |terrain,x,y| do
        yield terrain, @units[x,y], x, y
      end
    end
    
    
    def all_units
      @units.list
    end
  end
end