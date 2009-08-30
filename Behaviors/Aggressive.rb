module LD15
  module Behaviors
    module Aggressive
      module_function
      
      def plan(unit)
        target = nil
        moves  = 0
        4.times do |t|
          moves = t
          walkable = unit.range_data(unit.move*t)
          reachable = unit.reachable_tiles(walkable.available_tiles)
          target = nil
          available_targets = reachable.units_in_range(unit.map).select {|info| info[:unit].faction != unit.faction}
          if available_targets.empty?
            next
          else
            target = evaluate_targets(available_targets)
            break
          end
        end
        if target && moves == 0
          return Plan.new(nil,Action::Attack.new(target))
        elsif target && moves == 1
          path = data.paths[target[:square]][0...-1]
          return Plan.new(path,Action::Attack.new(target))
        elsif target
          path = data.paths[target[:square]][0,unit.move]
          return Plan.new(path,nil)
        else
          return Plan.new(nil,nil)
        end   
      end      
    end
  end
end