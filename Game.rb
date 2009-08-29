require 'Screen'

module LD15
  class Game < Screen
    def initialize(level)
      @map = Map.new(level)
    end
    def update
    end
    
    def draw
      @map.each_with_coords
    end
  end
end