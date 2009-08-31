module LD15
  module Actions
    Attack = Struct.new(:target) do
      def execute(game,unit)
        game.attacks(unit,self.target)
      end
    end
    Dig = Struct.new(:pattern,:dir) do
      def execute(game,unit)
        puts self.dir
        squares = self.pattern.squares(unit.gridsquare,self.dir).select{|square| unit.map.terrain_at(*square).digable?}
        squares.each do |square|
          unit.map.dig(*square)
        end
        unit.acted
        game.end_turn
      end
    end
  end
end