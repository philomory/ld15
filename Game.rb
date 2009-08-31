#require 'Screen'
#require 'Constants'
#require 'Map'
#require 'Unit/Digger'
#require 'Unit/Soldier'
#require 'State/PlayerChoosingMove'
#require 'State/PlayerChoosingAction'
#require 'State/AIDisplayMove'

##require 'State/AIDisplayAction'
##require 'State/AIDisplayEndTurn'

module LD15
  class Game < Screen
    attr_accessor :current_state, :current_unit
    def initialize(level)
      @map = Map.new(level)
      self.generate_teams
    end
    
    def generate_teams
      terrain = @map.terrain.to_a.transpose
      enemy_spaces = terrain[0,4].flatten.select {|tile| tile.is_a?(Terrain::EmptySpace)}.sort_by{|x| rand}.first(5)
      player_spaces = terrain.reverse[0,4].flatten.select {|tile| tile.is_a?(Terrain::EmptySpace)}.sort_by{|x| rand}.first(5)
      [[enemy_spaces,Factions::Enemy,:south],[player_spaces,Factions::Player,:north]].each do |spaces,faction,dir|
        units = [Unit::Soldier,Unit::Soldier,Unit::Soldier,Unit::Digger,Unit::Digger]
        spaces.each do |space|
          @map.add_unit(units.pop.new(@map,space.x,space.y,dir,faction))
        end
      end
    end
    
    def update
      if @current_state
        @current_state.update
      else
        self.time_passing
        @current_state.update
      end
    end
  
    def end_turn
      @current_unit.end_turn
      @current_unit = nil
      @current_state = nil
    end
    
    def battle_over?
      if !@map.all_units.any? {|unit| unit.faction == Factions::Player}
        @current_state = State::UIDisplayPlayerLoses.new(self)
        return true
      elsif !@map.all_units.any? {|unit| unit.faction == Factions::Enemy}
        @current_state = State::UIDisplayPlayerWins.new(self)
        return true
      else
        return false
      end
    end
    
    def attacks(attacker,target)
      damage = [attacker.strength - target.defense,0].max
      target.hurt_for(damage)
      attacker.acted
      @current_state = State::UIDisplayDamageDone.new(self,attacker,target,damage)
    end
    
    def pass_time
      @map.all_units.each do |unit|
        unit.tick
      end
    end
    
    def time_passing
      until self.ready_unit do
        self.pass_time
      end
      self.activate_unit(self.ready_unit)
    end
    
    def activate_unit(unit)
      @current_unit = unit
      if unit.faction == Factions::Player
        @current_state = State::PlayerChoosingAction.new(self)
      else
        plan = unit.plan_from_ai
        if plan.path
          @current_state = State::AIDisplayMove.new(self,plan)
        elsif plan.action
          @current_state = plan.action.execute(self,unit)
        else
          @current_state = State::AIDisplayEndTurn.new(self)
        end
      end
    end
    
    def ready_unit
      @map.all_units.find_all {|unit| unit.readiness >= 100}.sort_by {|u| [u.readiness,u.speed,u.object_id]}.first
    end
    
    def draw
      self.draw_map
      self.highlight_units
      @current_state.draw
    end
    
    def highlight_units
      @map.all_units.each {|unit| self.highlight_unit(unit)}
    end
    
    def highlight_unit(unit)
      color = case [(unit == @current_unit),(unit.faction == Factions::Player)]
      when [true,true]   : Color::ActiveFriendlyHighlight
      when [true,false]  : Color::ActiveUnfriendlyHighlight
      when [false,true]  : Color::InactiveFriendlyHighlight
      when [false,false] : Color::InactiveUnfriendlyHighlight
      end
      self.highlight_square(unit.gridsquare,color)
    end
    
    def draw_map
      @map.each_with_coords do |terrain, unit, x, y|
        x_pos = x * Sizes::TileWidth
        y_pos = y * Sizes::TileHeight
        ImageManager.image(terrain.key).draw(x_pos,y_pos,ZOrder::Terrain)
        ImageManager.image(unit.key).draw(x_pos,y_pos,ZOrder::Units) if unit
      end
    end
    
    def highlight_square(square,color)
      x_pos = square.x*Sizes::TileHeight
      y_pos = square.y*Sizes::TileWidth
      self.draw_square(x_pos,y_pos,Sizes::TileWidth,Sizes::TileHeight,color,ZOrder::Highlight)
    end
    
    def button_down(id)
      if id == Gosu::MsLeft
        @current_state.click
      else
        @current_state.menu.button_down(id) if @current_state.menu
      end
    end
    
    def mouse_is_over
      x,y = self.mouse_x,self.mouse_y
      if x.in?(0...@map.width*Sizes::TileWidth) && y.in?(0...@map.height*Sizes::TileHeight)
        return GridSquare.new((x/Sizes::TileWidth).to_i,(y/Sizes::TileHeight).to_i)
      else
        if @current_state.menu
          @current_state.menu.each do |item|
            if item.include?(x,y)
              return item
            end
          end
        end
      end
    end
  end
end