module LD15
  class Grid
    
    def self.from_array(array)
      width = array.length
      height = array[0].length
      grid = self.new(width,height)
      grid.instance_variable_set(:@spaces,array)
      return grid
    end
    
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
    
    def to_a
      @spaces.dup
    end
    
    def flatten
      @spaces.flatten
    end
    
    def list
      self.flatten.compact
    end
    
  end
end