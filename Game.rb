require 'Screen'
require 'Constants'
require 'Map'

module LD15
  class Game < Screen
    def initialize(level)
      @map = Map.new(level)
    end
    def update
    end
    
    def draw
      @map.each_with_coords do |terrain, unit, x, y|
        x_pos = x * Sizes::TileWidth
        y_pos = y * Sizes::TileHeight
        ImageManager.image(terrain.key).draw(x_pos,y_pos,ZOrder::Terrain)
        ImageManager.image(unit.key).draw(x_pos,y_pos,ZOrder::Units) if unit
      end
    end
  end
end