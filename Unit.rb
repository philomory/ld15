module LD15
  class Unit
    attr_reader :x, :y, :facing :health, :energy
    def initialize(x,y,facing)
      @x, @y, @facing = x, y, facing
      @health = self.class.const_get('HEALTH')
      @energy = self.class.const_get('ENERGY')
    end
  end
end