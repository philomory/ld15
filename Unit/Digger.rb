#require 'Unit'
#require 'DigPatterns/Line'
#require 'DigPatterns/ForwardBroad'
#require 'Behaviors/Stalker'

module LD15
  class Unit
    class Digger < Unit
      MAXHEALTH = 10
      MAXENERGY = 10
      SPEED     = 10
      MOVE      = 4
      STRENGTH  = 2
      DEFENSE   = 0
      AI = Behaviors::Stalker
      PATTERNS = [DigPatterns::Line.new(3),DigPatterns::ForwardBroad.new]
      
      def key
        "digger-#{@facing}"
      end

    end
  end
end