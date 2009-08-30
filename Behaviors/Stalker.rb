module LD15
  module Behaviors
    module Stalker
      module_function
      
      def plan(unit)
        # Scoping nonsense for ruby 1.8; 1.9 handles this better.
        target, moves, reachable, walkable = nil, 0, nil, nil
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
          return Plan.new(nil,nil)
        elsif target && moves == 1
          dest = reachable.paths[target[:square]][0]
          path = walkable.paths[dest]
          return Plan.new(path,nil)
        elsif target
          dest = reachable.paths[target[:square]][0]
          path = walkable.paths[dest][0,unit.move]
          return Plan.new(path,nil)
        else
          return Plan.new(nil,nil)
        end   
      end      

      def evaluate_targets(available_targets)
        return available_targets[rand(available_targets.length)]
      end
        
    end
  end
end