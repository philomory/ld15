require 'State'

module LD15
  class State < Screen
    class UIDisplayDamageDone < State
      def initialize(game,attacker,target,damage)
        @game, @target = game, target
        message = "Attacker hit target for #{damage} damage!"
        if target.dead?
          message << " Target has died!"
        end
        @menu = SidebarMenu.new(message) do |m|
          m.add("Continue",Gosu::KbEnter,Gosu::KbReturn) {self.done}
        end
      end
      
      def done
        unless @game.battle_over?
          @game.end_turn
        end
      end
      
      def draw
        super
        @game.highlight_square(@target.gridsquare,Color::ActiveUnfriendlyHighlight)
      end
      
    end
  end
end