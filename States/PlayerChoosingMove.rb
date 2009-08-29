require 'State'
require 'Screen'

module LD15
  class State < Screen
    class PlayerChoosingMove < State
      def initialize(game)
        @game = game
        @unit = game.current_unit
        @available_tiles = @unit.available_tiles_for_movement
      end

      def click
        over = @game.mouse_is_over
        if over.in?(@available_tiles)
          @game.current_state = UnitMovedToSquare.new(@game,over)
        end
      end


      def update
      end

      def draw
        self.draw_unit_highlight
        self.draw_move_range
        self.draw_mouse_square
      end

      def draw_mouse_square
        over = @game.mouse_is_over
        if over.is_a?GridSquare
          if over.in?(@available_tiles)
            @game.highlight_square(over,Color::ValidDestHighlight)
          else
            @game.highlight_square(over,Color::InvalidDestHighlight)
          end
        end
      end
      
      def draw_unit_highlight
        @game.highlight_square(@unit.gridsquare,Color::ActiveUnitHighlight)
      end
      
      def draw_move_range
        @available_tiles.each do |tile|
          @game.highlight_square(tile,Color::MoveHighlight)
        end
      end
    end
  end
end