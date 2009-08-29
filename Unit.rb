module LD15
  class Unit
    
    attr_reader :map, :x, :y, :facing, :health, :maxhealth, :energy, :maxenergy, :speed, :readiness
    def initialize(map,x,y,facing)
      @x, @y, @facing = x, y, facing
      %w{MAXHEALTH MAXENERGY SPEED MOVE}.each do |name|
        ivar = '@' + name.downcase
        self.instance_variable_set(ivar,self.class.const_get(name))
      end
      @readiness = 0
      @healt, @energy = @maxhealth, @maxenergy
    end
    
    def available_tiles_for_movement
    end
    
  end
end