module LD15
  class State < Screen
    class UIDisplayPlayerWins < State
      def initialize(game)
        @menu = SidebarMenu.new("All enemy units are dead! That means you win!\n :) :) :)") do |m|
          m.add("Start Over") {MainWindow.new_game}
          m.add("Quit") {MainWindow.close}
        end
      end
    end
  end
end