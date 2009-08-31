module LD15
  module Behaviors
    module Stalker
      extend self
      
      def plan(unit)
        # Scoping nonsense for ruby 1.8; 1.9 handles this better.
        target, moves, reachable, walkable = nil, 0, nil, nil
        4.times do |t|
          moves = t
          walkable = unit.range_data(unit.move*t)
          reachable = unit.reachable_tiles(walkable.available_tiles)
          target = nil
          available_targets = reachable.enemies_in_range(unit)
          if available_targets.empty?
            next
          else
            target = evaluate_targets(available_targets)
            break
          end
        end
        if target && moves == 0
          return Plan.new(nil,self.action_for_target(target[:unit]))
        elsif target && moves == 1
          dest = reachable.paths[target[:square]][0]
          path = (walkable.paths[dest]+[dest])
          return Plan.new(path,self.action_for_target(target[:unit]))
        elsif target
          dest = reachable.paths[target[:square]][0]
          path = (walkable.paths[dest]+[dest])[0,unit.move+1]
          return Plan.new(path,nil)
        else
          dest = walkable.available_tiles[rand(walkable.available_tiles.length)]
          path = (walkable.paths[dest]+[dest])[0,unit.move+1]
          return Plan.new(path,nil)
        end   
      end      

      def action_for_target(target)
        nil
      end

      def evaluate_targets(available_targets)
        return available_targets[rand(available_targets.length)]
      end
        
    end
  end
end