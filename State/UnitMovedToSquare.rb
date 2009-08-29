require 'State'
require 'Screen'

module LD15
  class State < Screen
    class UnitMovedToSquare < State
      def initialize(game,dest,path)
        @game,@dest,@path = game,dest,path
        @unit = game.current_unit
      end
    end
    
    def draw
      self.draw_unit_highlight
      self.draw_path
      self.draw_dest
    end
    
    def draw_path
      @path.each do |square|
        @game.highlight_square(square,Color::MoveHighlight)
      end
    end
    
    def draw_dest
      @game.highlight_square(@dest,Color::ValidDestHighlight)
    end
    
  end
end