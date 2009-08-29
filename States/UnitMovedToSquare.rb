require 'State'
require 'Screen'

module LD15
  class State < Screen
    class PlayerChoosingMove < State
      def initialize(game)
        @game = game
        @unit = game.current_unit
        @available_tiles = @unit.available_tiles_for_movement
      end