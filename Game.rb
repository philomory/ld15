require 'Screen'
require 'Constants'
require 'Map'
require 'Unit/Digger'

module LD15
  class Game < Screen
    def initialize(level)
      @map = Map.new(level)
      @current_unit = Unit::Digger.new(@map,10,18,:north)
      @map.add_unit(@current_unit)
    end
    def update
      
    end
    
    def draw
      self.draw_map
      self.draw_move_range
    end
    
    def draw_map
      @map.each_with_coords do |terrain, unit, x, y|
        x_pos = x * Sizes::TileWidth
        y_pos = y * Sizes::TileHeight
        ImageManager.image(terrain.key).draw(x_pos,y_pos,ZOrder::Terrain)
        ImageManager.image(unit.key).draw(x_pos,y_pos,ZOrder::Units) if unit
      end
    end
    
    def draw_move_range
      available_tiles = @current_unit.available_tiles_for_movement
      available_tiles.each do |tile| 
        self.draw_square(tile.x,tile.y,Sizes::TileWidth,Sizes::TileHeight,0x999aFFFF)
      end
    end
  end
end