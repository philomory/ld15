#require 'State/UnitMovedToSquare'

module LD15
  class State < Screen
    class AIDisplayMove < UnitMovedToSquare
      def initialize(game,plan)
        @game,@plan = game, plan
        @path = @plan.path
        @dest = @path[-1]
        
        @unit = game.current_unit
        @menu = SidebarMenu.new("AI moves unit.") do |m|
          m.add("Continue",Gosu::KbEnter,Gosu::KbReturn,Gosu::KbEscape) {self.done}
        end
      end
      
      def done
        @unit.move_to(@dest)
        @plan.path = nil
        if @plan.action
          @plan.action.execute(@game,@unit)
        else
          @game.current_state = State::AIDisplayEndTurn.new(@game)
        end
      end


      def draw
        super
        self.draw_unit_highlight(@unit)
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
end