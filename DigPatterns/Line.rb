require 'helper'

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
        return ([dir]*@length).inject(self.gridsquare) {|sq,dir| sq.send(dir)}
      end
    end
  end
end