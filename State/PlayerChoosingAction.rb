require 'Screen'
require 'State'
require 'State/PlayerChoosingMove'
require 'State/PlayerChoosingDigPattern'

module LD15
  class State < Screen
    class PlayerChoosingAction < State
      def initialize(game)
        @game = game
        @unit = @game.current_unit
        @menu = SidebarMenu.new("Action") do |m|
          if @unit.moved?
            m.disabled("Move")
          else
            m.add("Move",Gosu::KbM,Gosu::KbEnter,Gosu::KbReturn) {@game.current_state=PlayerChoosingMove.new(@game)}
          end
          m.add("Dig",Gosu::KbD,Gosu::KbSpace) {@game.current_state=PlayerChoosingDigPattern.new(@game)}
          #m.add("Attack",Gosu::KbA) {@game.current_state = PlayerChoosingAttack.new(@game)}
          #m.add("Special",Gosu::KbS) {@game.current_state = PlayerChoosingSpecial.new(@game)}
          m.add("End Turn",Gosu::KbEscape) {@game.end_turn}
        end
      end
      
      def draw
        super
        self.draw_unit_highlight(@unit)
      end
    end
  end
end