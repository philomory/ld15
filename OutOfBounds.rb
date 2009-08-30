#require 'Terrain'

module LD15
  class OutOfBounds
    def passable?
      false
    end
    def digable?
      false
    end
  end
end