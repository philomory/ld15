#require 'GridSquare'
#require 'MoveData'

module LD15
  class Unit
    
    attr_reader :map, :x, :y, :facing, :health, :maxhealth, :energy, :maxenergy
    attr_reader :speed, :readiness, :move, :faction, :patterns, :strength, :defense
    attr_writer :facing
    def initialize(map,x,y,facing,faction)
      @map, @x, @y, @facing, @faction = map, x, y, facing, faction
      %w{MAXHEALTH MAXENERGY SPEED MOVE STRENGTH DEFENSE PATTERNS AI}.each do |name|
        ivar = '@' + name.downcase
        self.instance_variable_set(ivar,self.class.const_get(name))
      end
      @readiness = 0
      @health, @energy = @maxhealth, @maxenergy
      @moved, @acted = false, false
    end
    
    def gridsquare
      return GridSquare.new(@x,@y)
    end
    
    def hurt_for(damage)
      @health -= damage
      if self.dead?
        @map.remove_unit(self)
      end
    end
    
    def alive?
      return @health > 0
    end
    
    def dead?
      return !self.alive?
    end
    
    def inspect
      "#<#{self.class}:#{self.object_id.to_s(16)} @x=#{@x}, @y=#{@y}>"
    end
    
    #def available_dig_directions
    #  [:north,:south,:east,:west]
    #end
    
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
    
    def acted
      @acted = true
    end
    
    def acted?
      @acted
    end
    
    def end_turn
      if @acted
        @readiness -= 100
      elsif @moved
        @readiness -= 80
      else
        @readiness -= 60
      end
      @acted, @moved = false, false
    end
    
    def range_data(range)
      available_tiles = []
      paths = {self.gridsquare => []}
      edge_tiles = [self.gridsquare]
      new_edge_tiles = []
      range.times do
        new_edge_tiles = []
        edge_tiles.each do |tile|
          [:north,:south,:east,:west].each do |dir|
            test_tile = tile.send(dir)
            if @map.can_pass?(self,test_tile.x,test_tile.y) and not (available_tiles + edge_tiles).include?(test_tile)
              new_edge_tiles.push(test_tile)
              paths[test_tile] = paths[tile].dup.push(tile)
            end #if
          end #each do |dir|
        end #each do |tile|
        available_tiles += edge_tiles
        edge_tiles = new_edge_tiles
      end #range.times do
      available_tiles += edge_tiles
      return MoveData.new(available_tiles,paths)
    end
    
    def reachable_tiles(from_tiles=[self.gridsquare])
      reachable = []
      paths = {}
      from_tiles.each do |tile|
        [:north,:south,:east,:west].each do |dir|
          new_tile = tile.send(dir)
          unless (@map.terrain_at(*new_tile).is_a?(OutOfBounds) || reachable.include?(new_tile))
            reachable << new_tile
            paths[new_tile] = [tile]
          end
        end
      end
      return MoveData.new(reachable,paths)
    end
    
    def plan_from_ai(behavior = @ai)
      return behavior.plan(self)
    end
    
    def move_data
      data = self.range_data(@move)
      data.available_tiles.uniq!.reject! {|tile| @map.unit_at(tile.x,tile.y)}
      return data
    end
    
  end
end