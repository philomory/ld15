require 'Screen'
require 'State'
#require 'State/PlayerConfirmsDig'

module LD15
  class State < Screen
    class PlayerChoosingDigDirection < State
      def initialize(parent,game,pattern)
        @parent, @game, @pattern = parent, game, pattern
        @unit = @game.current_unit
        @menu = SidebarMenu.new("Choose a direction:") do |m|
          m.key_only(Gosu::KbUp,Gosu::KbN) {self.chooses(:north)}
          m.key_only(Gosu::KbDown,Gosu::KbS) {self.chooses(:south)}
          m.key_only(Gosu::KbRight,Gosu::KbE) {self.chooses(:east)}
          m.key_only(Gosu::KbLeft,Gosu::KbW) {self.chooses(:west)}
          m.add("Cancel",Gosu::KbEscape) {@game.current_state = @parent}
        end
      end
      
      def chooses(dir)
        
      end
      
      
    end
  end
end