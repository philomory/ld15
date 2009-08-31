module LD15
  class State < Screen
    class UIDisplayPlayerLoses < State
      def initialize(game)
        @menu = SidebarMenu.new("Oh no! All your units are dead! That means you lost!\n :( :( :(") do |m|
          m.add("Start Over") {MainWindow.new_game}
          m.add("Quit") {MainWindow.close}
        end
      end
    end
  end
end