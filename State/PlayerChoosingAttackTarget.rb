require 'State'

module LD15
  class State < Screen
    class PlayerChoosingAttackTarget < State
      def initialize(parent,game)
        @parent, @game = parent, game
        @unit = @game.current_unit
        @available_targets = @unit.reachable_tiles.enemies_in_range(@unit)
        @available_squares = @available_targets.map {|info| info[:square]}
        if @available_targets.empty?
          @menu = SidebarMenu.new("This unit cannot reach any enemies!!") do |m|
            m.add("Back",Gosu::KbEnter,Gosu::KbReturn,Gosu::KbEscape) {@game.current_state = @parent}
          end
        else
          @menu = SidebarMenu.new("Click a target:") do |m|
            #m.add("Confirm",Gosu::KbEnter,Gosu::KbReturn) {self.confirm}
            m.add("Cancel",Gosu::KbEscape) {self.cancel}
          end
        end
      end
      
      def clicked_square(square)
        if square.in?(@available_squares)
          @game.current_state = PlayerConfirmsAttack.new(self,@game,@unit.map.unit_in_square(*square))
        end
      end
      
      def draw
        super
        @available_squares.each do |square|
          @game.highlight_square(square,Color::PotentialTargetHighlight)
        end
      end
      
    end
  end
end