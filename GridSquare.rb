module LD15
  GridSquare = Struct.new(:x,:y) do
    def north
      return GridSquare.new(x,y-1)
    end
    def south
      return GridSquare.new(x,y+1)
    end
    def east
      return GridSquare.new(x+1,y)
    end
    def west
      return GridSquare.new(x-1,y)
    end
  end
end