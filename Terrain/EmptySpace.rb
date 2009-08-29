require 'Terrain'

module LD15
  class Terrain
    class EmptySpace < Terrain
      def key
        'floor'
      end
      def passable?
        true
      end
    end
  end
end
