#require 'Terrain'

module LD15
  class Terrain
    class EmptySpace < Terrain
      def key
        'floor'
      end
      def passable?
        true
      end
      def digable?
        false
      end
    end
  end
end
