module LD15
  module Actions
    Attack = Struct.new(:target) do
      def execute(game,unit)
        game.attacks(unit,self.target)
      end
    end
    Dig = Struct.new(:pattern,:dir) do
      def execute(game,unit)
      end
    end
  end
end