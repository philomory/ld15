#require 'Screen'
#require 'SidebarMenu'

module LD15
  class State < Screen
    attr_reader :menu
    def draw
      @menu.draw if @menu
    end
    
    def draw_unit_highlight(unit)
      color = case [(unit == @game.current_unit),(unit.faction == Factions::Player)]
      when [true,true]   : Color::ActiveFriendlyHighlight
      when [true,false]  : Color::ActiveUnfriendlyHighlight
      when [false,true]  : Color::InactiveFriendlyHighlight
      when [false,false] : Color::InactiveUnfriendlyHighlight
      end
      @game.highlight_square(unit.gridsquare,color)
    end
    
    def click
      over = @game.mouse_is_over
      if over.is_a?(GridSquare)
        self.clicked_square(over)
      elsif over.is_a?(SidebarItem)
        over.clicked
      end
    end
    
    def clicked_square(square)
    end
    
  end
end