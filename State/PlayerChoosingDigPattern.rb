#require 'Screen'
#require 'State'
#require 'State/PlayerChoosingDigDirection'

module LD15
  class State < Screen
    class PlayerChoosingDigPattern < State
      def initialize(game)
        @game = game
        @unit = @game.current_unit
        @menu = SidebarMenu.new("Choose a Pattern:") do |m|
          @unit.patterns.each_with_index do |pattern,index|
            key_equiv = Gosu::Window.char_to_button_id(((index+1)%10).to_s) if index < 9
            title = if key_equiv
              "#{index+1}. #{pattern.title}"
            else
              pattern.title
            end
            m.add(title,key_equiv) {self.chooses(pattern)}
          end
          m.add("Cancel",Gosu::KbEscape) {@game.current_state = PlayerChoosingAction.new(@game)}
        end
      end
      
      def chooses(pattern)
        @game.current_state = if pattern.directions
          PlayerChoosingDigDirection.new(self,@game,pattern)
        else
          PlayerConfirmsDig.new(self,@game,pattern.squares(@unit.gridsquare))
        end
      end
      
    end
  end
end