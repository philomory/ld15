#require 'Terrain'

module LD15
  class Terrain
    class Dirt < Terrain
      def key
        'dirt'
      end
      def passable?
        false
      end
      def digable?
        true
      end
    end
  end
end
