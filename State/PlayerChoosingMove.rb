require 'State'
require 'Screen'
require 'State/UnitMovedToSquare'

module LD15
  class State < Screen
    class PlayerChoosingMove < State
      def initialize(game)
        @game = game
        @unit = game.current_unit
        move_data = @unit.move_data
        @available_tiles = move_data.available_tiles
        @paths = move_data.paths
      end

      def clicked_square(square)
        if square.in?(@available_tiles)
          @game.current_state = UnitMovedToSquare.new(@game,square,@paths[square])
        end
      end


      def update
      end

      def draw
        super
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
      
      def draw_move_range
        @available_tiles.each do |tile|
          @game.highlight_square(tile,Color::MoveHighlight)
        end
      end
    end
  end
end