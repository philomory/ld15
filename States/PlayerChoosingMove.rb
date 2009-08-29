require 'State'
require 'Screen'

module LD15
  class State < Screen
    class PlayerChoosingMove < State
      def initialize(game)
        @game = game
      end

      def update
      end

      def draw
        self.draw_unit_highlight
        self.draw_move_range
      end

      def draw_move_range
        available_tiles = @game.current_unit.available_tiles_for_movement
        available_tiles.each do |tile|
          @game.highlight_square(tile,Color::MoveHighlight)
        end
      end
    end
  end
end