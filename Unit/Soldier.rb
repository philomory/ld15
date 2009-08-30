#require 'Unit'
#require 'DigPatterns/Line'
#require 'Behaviors/Stalker'

module LD15
  class Unit
    class Soldier < Unit
      MAXHEALTH = 30
      MAXENERGY = 10
      SPEED     = 9
      MOVE      = 3
      STRENGTH  = 2
      DEFENSE   = 1
      PATTERNS = [DigPatterns::Line.new(1)]
      AI = Behaviors::Stalker      
      
      
      def key
        "soldier-#{@facing}"
      end

    end
  end
end