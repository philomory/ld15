module LD15
  class Grid
    
    attr_reader :width, :height
    def initialize(width,height)
      @width, @height = width, height
      @spaces = Array.new(@width) {Array.new(@height)}
    end
    def [](x,y)
      return @spaces[x][y]
    end
    
    def []=(x,y,val)
      @spaces[x][y] = val
    end
    
    def each
      @spaces.each do |col|
        col.each do |obj|
          yield obj
        end
      end
    end
    
    def each_with_coords
      @spaces.each_with_index do |col,x|
        col.each_with_index do |obj,y|
          yield obj, x, y
        end
      end
    end
    
    def flatten
      @spaces.flatten
    end
    
    def list
      self.flatten.compact
    end
    
  end
end