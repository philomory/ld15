require 'Terrain'

module LD15
  class Terrain
    class SolidWall < Terrain
      def key 
        'wall'
      end
      def passable?
        false
      end
    end
  end
end
    