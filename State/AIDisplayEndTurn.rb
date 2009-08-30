require 'State'

module LD15
  class State < Screen
    class AIDisplayEndTurn < State
      def initialize(game)
        @game = game
        @unit = @game.current_unit
        @menu = SidebarMenu.new("AI is finished turn.") do |m|
          m.add("Yes",Gosu::KbEnter,Gosu::KbReturn,Gosu::KbEscape) {@game.end_turn}
        end
      end
      
      
      
      def draw
        super
        self.draw_unit_highlight(@unit)
      end
      
    end
  end
end