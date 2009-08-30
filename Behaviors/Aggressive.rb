module LD15
  module Behaviors
    module Aggressive
      include Stalker
      extend self

      def action_for_target(target)
        Actions::Attack.new(target)
      end

    end
  end
end