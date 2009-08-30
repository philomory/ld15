require 'GridSquare'
require 'MoveData'

module LD15
  class Unit
    
    attr_reader :map, :x, :y, :facing, :health, :maxhealth, :energy, :maxenergy, :speed, :readiness, :move, :faction
    def initialize(map,x,y,facing,faction)
      @map, @x, @y, @facing, @faction = map, x, y, facing, faction
      %w{MAXHEALTH MAXENERGY SPEED MOVE}.each do |name|
        ivar = '@' + name.downcase
        self.instance_variable_set(ivar,self.class.const_get(name))
      end
      @readiness = 0
      @healt, @energy = @maxhealth, @maxenergy
      @moved, @acted = false, false
    end
    
    def gridsquare
      GridSquare.new(@x,@y)
    end
    
    def available_dig_directions
      [:north,:south,:east,:west]
    end
    
    def tick
      @readiness += @speed
    end
    
    def move_to(square)
      @x, @y, oldx, oldy = square.x, square.y, x, y
      @map.unit_moved_from(self,oldx,oldy)
      @moved = true
    end
    
    def moved?
      @moved
    end
    
    def end_turn
      if @acted
        @readiness -= 100
      elsif @moved
        @readiness -= 60
      else
        @readiness -= 30
      end
      @acted, @moved = false, false
    end
    
    def move_data
      available_tiles = []
      paths = {self.gridsquare => []}
      edge_tiles = [self.gridsquare]
      new_edge_tiles = []
      @move.times do
        new_edge_tiles = []
        edge_tiles.each do |tile|
          [:north,:south,:east,:west].each do |dir|
            test_tile = tile.send(dir)
            if @map.can_pass?(self,test_tile.x,test_tile.y) and not (available_tiles + edge_tiles).include?(test_tile)
              new_edge_tiles.push(test_tile)
              paths[test_tile] = paths[tile].dup.unshift(tile)
            end #if
          end #each do |dir|
        end #each do |tile|
        available_tiles += edge_tiles
        edge_tiles = new_edge_tiles
      end #@move.times do
      available_tiles += edge_tiles
      available_tiles.uniq!.reject! {|tile| @map.unit_at(tile.x,tile.y)}
      return MoveData.new(available_tiles,paths)
    end
    
  end
end