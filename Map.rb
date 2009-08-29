require 'helper'

require 'Grid'
require 'Terrain'
LD15::Terrain.load_terrain
require 'Unit'

module LD15
  class Map
    
    KEYS = {
      '#' => Terrain::SolidWall,
      '~' => Terrain::Dirt,
      '.' => Terrain::EmptySpace
    }
    
    attr_reader :width, :height
    def initialize(level)
      @terrain = load_data(level)
      
      @units   = Grid.new(@width,@height)
    end
    
    def load_data(path)
      file = File.open(path,'r')
      data = file.read
      file.close
      array = data.split("\n").map {|row| row.split('')}.transpose
      data_grid = Grid.from_array(array)
      @width, @height = data_grid.width, data_grid.height
      terrain_grid = Grid.new(@width,@height)
      data_grid.each_with_coords do |key,x,y|
        terrain_grid[x,y] = KEYS[key].new(x,y)
      end
      return terrain_grid
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
      @terrain.each_with_coords do |terrain,x,y|
        yield terrain, @units[x,y]
      end
    end
    
    def each_with_coords
      @terrain.each_with_coords do |terrain,x,y|
        yield terrain, @units[x,y], x, y
      end
    end
    
    
    def all_units
      @units.list
    end
  end
end