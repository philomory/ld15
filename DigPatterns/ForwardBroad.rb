#require 'helper'

module LD15
  module DigPatterns
    class ForwardBroad
      attr_reader :title, :directions
      def initialize
        @title = "Forward Broad"
        @directions = [:north,:west,:south,:east]
      end
      
      def squares(start,dir)
        squares_ary = [start.send(dir)]
        squares_ary << squares_ary[0].send(rot_cw(dir))
        squares_ary << squares_ary[0].send(rot_ccw(dir))
        return squares_ary
      end
    end
  end
end