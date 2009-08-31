#require 'Screen'
#require 'State'
#require 'State/PlayerChoosingMove'
#require 'State/PlayerChoosingDigPattern'

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
          m.add("Dig",Gosu::KbD,Gosu::KbSpace) {self.dig}
          targets = @unit.reachable_tiles.enemies_in_range(@unit)
          case targets.length
          when 0 : m.disabled("Attack")
          when 1 : m.add("Attack",Gosu::KbA) {@game.current_state = PlayerConfirmsAttack.new(self,@game,targets[0][:unit])}
          else     m.add("Attack",Gosu::KbA) {@game.current_state = PlayerChoosingAttackTarget.new(self,@game)}
          end
          #m.add("Special",Gosu::KbS) {@game.current_state = PlayerChoosingSpecial.new(@game)}
          m.add("End Turn",Gosu::KbEscape) {@game.end_turn}
        end
      end
      
      def dig
        if @unit.patterns.length == 1
          if @unit.patterns[0].directions
            @game.current_state=PlayerChoosingDigDirection.new(self,@game,@unit.patterns[0])
          else
            @game.current_state = PlayerConfirmsDig.new(self,@game,@unit.patterns[0].squares(@unit.gridsquare))
          end
        else
          @game.current_state=PlayerChoosingDigPattern.new(@game)
        end
      end
      
      
      def draw
        super
        self.draw_unit_highlight(@unit)
      end
    end
  end
end