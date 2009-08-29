require 'Unit'

module LD15
  class Unit
    class Digger < Unit
      MAXHEALTH = 10
      MAXENERGY = 10
      SPEED     = 10
      MOVE      = 4
      def key
        'digger'
      end
    end
  end
end