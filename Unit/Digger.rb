require 'Unit'

module LD15
  class Unit
    class Digger < Unit
      MAXHEALTH = 10
      MAXENERGY = 10
      SPEED     = 10
      MOVE      = 4
      PATTERNS = [DigPatterns::Line.new(3),DigPatterns::ForwardBroad.new]
      def key
        'digger'
      end

    end
  end
end