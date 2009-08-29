require 'Screen'
require 'Constants'
require 'Map'
require 'Unit/Digger'
require 'States/PlayerChoosingMove'

module LD15
  class Game < Screen
    attr_accessor :current_state, :current_unit
    def initialize(level)
      @map = Map.new(level)
      @current_unit = Unit::Digger.new(@map,10,18,:north,0)
      @current_state = State::PlayerChoosingMove.new(self)
      @map.add_unit(@current_unit)
    end
    def update
      @current_state.update
    end
    
    def draw
      self.draw_map
      self.draw_mouse_square
      #self.draw_move_range
    end
    
    def draw_map
      @map.each_with_coords do |terrain, unit, x, y|
        x_pos = x * Sizes::TileWidth
        y_pos = y * Sizes::TileHeight
        ImageManager.image(terrain.key).draw(x_pos,y_pos,ZOrder::Terrain)
        ImageManager.image(unit.key).draw(x_pos,y_pos,ZOrder::Units) if unit
      end
    end
    
    def highlight_square(square,color)
      x_pos = square.x*Sizes::TileHeight
      y_pos = square.y*Sizes::TileWidth
      self.draw_square(x_pos,y_pos,Sizes::TileWidth,Sizes::TileHeight,color,ZOrder::Highlight)
    end
    
    def draw_mouse_square
      if (square=self.mouse_is_over)
        self.highlight_square(square,Color::UnderCursorHighlight)
      end
    end
    
    def mouse_is_over
      x,y = self.mouse_x,self.mouse_y
      if x.in?(0...@map.width*Sizes::TileWidth) && y.in?(0...@map.height*Sizes::TileHeight)
        return GridSquare.new((x/Sizes::TileWidth).to_i,(y/Sizes::TileHeight).to_i)
      else
        return nil
      end
    end

  end
end