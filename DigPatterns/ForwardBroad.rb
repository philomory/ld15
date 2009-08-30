require 'helper'

module LD15
  module DigPatterns
    class ForwardBroad
      def initialize
        @title = "Forward Broad"
        @directions = [:north,:west,:south,:east]
      end
      
      def squares(start,dir)
        squares_ary = [start.send(dir)]
        squares_ary << pat2[0].send(rot_cw(dir))
        squares_ary << pat2[0].send(rot_ccw(dir))
        return squares_ary
      end
    end
  end
end