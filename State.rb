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
      over = @game.mouse_is_over
      if over.is_a?(GridSquare)
        self.clicked_square(over)
      elsif over.is_a?(SidebarItem)
        over.clicked
      end
    end
    
  end
end