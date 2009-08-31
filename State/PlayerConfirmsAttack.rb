require 'State'

module LD15
  class State < Screen
    class PlayerConfirmsAttack < State
      def initialize(parent,game,target)
        @parent, @game, @target = parent, game, target
        @unit = @game.current_unit
        @menu = SidebarMenu.new("Is this who you'd like to attack?") do |m|
          m.add("Yes.",Gosu::KbY,Gosu::KbEnter,Gosu::KbReturn) {@game.attacks(@unit,@target)}
          m.add("No.",Gosu::KbN,Gosu::KbEscape) {@game.current_state = @parent} 
        end
      end
      
      def draw
        super
        @game.highlight_square(@target.gridsquare,Color::ActiveUnfriendlyHighlight)
      end
      
      
    end
  end
end