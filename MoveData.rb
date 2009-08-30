module LD15
  MoveData = Struct.new(:available_tiles,:paths) do
    def units_in_range(map)
      return self.available_tiles.map {|square| {:square => square,:unit => map.unit_at(*square)}}.select {|h| h[:unit]}
    end
  end
end