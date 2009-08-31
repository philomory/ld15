module LD15
  MoveData = Struct.new(:available_tiles,:paths) do
    def units_in_range(map)
      return self.available_tiles.map {|square| {:square => square,:unit => map.unit_at(*square)}}.select {|h| h[:unit]}
    end
    def enemies_in_range(unit)
      return self.units_in_range(unit.map).select {|info| info[:unit].faction != unit.faction}
    end
    def allies_in_range(unit)
      return self.units_in_range(unit.map).select {|info| info[:unit].faction == unit.faction}
    end
    def dirt_in_range(map)
      return self.available_tiles.select {|square| map.terrain_at(*square).is_a?(Dirt)}
    end
  end
end