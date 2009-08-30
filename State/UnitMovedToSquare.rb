#require 'State'
#require 'Screen'

module LD15
  class State < Screen
    class UnitMovedToSquare < State
      def initialize(game,dest,path)
        @game,@dest,@path = game,dest,path
        @unit = game.current_unit
        @menu = SidebarMenu.new("Do you wish to move here?") do |m|
          m.add("Yes",Gosu::KbEnter,Gosu::KbReturn,Gosu::KbY) {@unit.move_to(@dest);@game.current_state = PlayerChoosingAction.new(@game)}
          m.add("No",Gosu::KbEscape,Gosu::KbN) {@game.current_state = PlayerChoosingMove.new(@game)}
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