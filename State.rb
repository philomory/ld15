require 'Screen'

module LD15
  class State < Screen
    
    def draw_unit_highlight
      @game.highlight_square(@unit.gridsquare,Color::ActiveUnitHighlight)
    end
    
    def click
    end
    
  end
end