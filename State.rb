require 'Screen'
require 'SidebarMenu'

module LD15
  class State < Screen
    attr_reader :menu
    def draw
      @menu.draw if @menu
    end
    
    def draw_unit_highlight
      @game.highlight_square(@unit.gridsquare,Color::ActiveUnitHighlight)
    end
    
    def click
    end
    
  end
end