module LD15
  module Behaviors
    module Excavator
      extend self

      def plan(unit)
        if @unit.reachable_tiles.enemies_in_range(unit).empty?
          action, target, moves, reachable, walkable = nil, nil, 0, nil, nil
          2.times do |t|
            moves = t
            walkable = unit.range_data(unit.move*t)
            reachable = unit.reachable_tiles(walkable.available_tiles)
            target = nil
            available_dirt = reachable.dirt_in_range(unit.map)
            if available_dirt.empty?
              next
            elsif moves = 0
              action = self.evaluate_dig(unit,unit.gridsquare,available_dirt)
              break
            else
              target_dirt = self.evaluate_dirt(available_dirt)
              break
            end
          end
          if action
            return Plan.new(nil,action)
          elsif target
            dest = reachable.paths[target_dirt][0]
            path = (walkable.paths[dest]+[dest])
            action = self.evaluate_digs(unit,dest,target_dirt)
            return Plan.new(path,action)
          else
            dest = walkable.available_tiles[rand(walkable.available_tiles.length)]
            path = (walkable.paths[dest]+[dest])[0,unit.move+1]
            return Plan.new(path,nil)
          end
        else
          walkable = unit.range_data(unit.move)
          digable  = unit.reachable_tiles(unit.grid_square).dirt_in_range(unit.map)
          if !walkable.empty?
            self.attempt_to_flee(unit,walkable)
          elsif !digable.empty?
            action = self.evaluate_dig(unit,unit.gridsquare,digable)
            return Plan.new(nil,action)
          else
            self.fight
          end
        end
      end

      def evaluate_dirt(available_dirt)
        return available_dirt[rand(available_dirt.length)]
      end

      def evaluate_dig(unit,square,available_dirt)
        dirs = [:north,:south,:east,:west].select {|dir| square.send(dir).in?(available_dirt)}
        dir = dirs[rand(dirs.length)]
        pattern = unit.patterns[rand(unit.patterns.length)]
        return Actions::Dig.new(pattern,dir)
      end

      def attempt_to_flee(unit,walkable)
        happy = walkable.select do
          
        end
        return nil
      end

      def fight
        return Plan.new(nil,nil)
      end

    end
  end
end