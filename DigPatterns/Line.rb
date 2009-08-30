#require 'helper'

module LD15
  module DigPatterns
    class Line
      attr_reader :title, :directions
      def initialize(length)
        @length = length
        @title = "Line (#{@length})"
        @directions = [:north,:west,:south,:east]
      end
      
      def squares(start,dir)
        squares = []
        @length.times {squares << (squares[-1] || start).send(dir)}
        return squares
      end
    end
  end
end