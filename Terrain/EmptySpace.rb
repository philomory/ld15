require 'Terrain'

module LD15
  class Terrain
    class EmptySpace < Terrain
      def key
        'floor'
      end
    end
  end
end
