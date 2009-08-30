#require 'Screen'
#require 'State'

module LD15
  class State < Screen
    class PlayerChoosingDigDirection < State
      def initialize(parent,game,pattern)
        @parent, @game, @pattern = parent, game, pattern
        @unit = @game.current_unit
        @original_facing = @unit.facing
        self.init_squares
        if @digable_squares.keys.empty?
          @menu = SidebarMenu.new("This dig pattern cannot reach any dirt from here!") do |m|
            m.add("Back",Gosu::KbEnter,Gosu::KbReturn,Gosu::KbEscape) {@game.current_state = @parent}
          end
        else
          self.choose(self.default_dir)
          @menu = SidebarMenu.new("Choose a direction:") do |m|
            m.key_only(Gosu::KbUp,Gosu::KbN) {self.choose(:north)} if @digable_squares.keys.include?(:north)
            m.key_only(Gosu::KbDown,Gosu::KbS) {self.choose(:south)} if @digable_squares.keys.include?(:south)
            m.key_only(Gosu::KbRight,Gosu::KbE) {self.choose(:east)} if @digable_squares.keys.include?(:east)
            m.key_only(Gosu::KbLeft,Gosu::KbW) {self.choose(:west)} if @digable_squares.keys.include?(:west)
            m.add("Confirm",Gosu::KbEnter,Gosu::KbReturn) {self.confirm}
            m.add("Cancel",Gosu::KbEscape) {self.cancel}
          end
        end
      end
      
      def choose(dir)
        @dir = dir
        @unit.facing = dir
      end  
      
      def cancel
        @unit.facing = @original_dir
        @game.current_state = @parent
      end
      
      def default_dir
        @digable_squares.to_a.sort_by {|pair| -pair[1].length}.first.first
      end
      
      def init_squares
        @digable_squares = {}
        [:north,:south,:east,:west].each do |dir|
          squares = @pattern.squares(@unit.gridsquare,dir).select{|square| @unit.map.terrain_at(*square).digable?}
          unless squares.empty?
            @digable_squares[dir] = squares
          end
        end
      end
      
      def confirm
        @digable_squares[@dir].each do |square|
          @unit.map.dig(*square)
        end
        @unit.acted
        @game.end_turn
      end
      
      def draw
        super
        drawn = []
        @digable_squares[@dir].each do |square|
          @game.highlight_square(square,Color::EffectAreaHighlight)
          drawn << square
        end
        @digable_squares.values.each do |squares|
          squares.each do |square|
            @game.highlight_square(square,Color::MoveHighlight) unless drawn.include?(square)
            drawn << square
          end
        end
      end
    end
  end
end