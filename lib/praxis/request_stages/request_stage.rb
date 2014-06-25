module Praxis
  module RequestStages

    class RequestStage < Stage
      extend Forwardable

      def_delegators :@context, :controller, :action, :request

      def path
        [name]
      end

      def execute_controller_callbacks(callbacks)
        if callbacks.has_key?(path)
          callbacks[path].each do |(conditions, block)|
            # TODO: support more conditions
            if conditions.has_key?(:actions)
              next unless conditions[:actions].include? action.name
            end
            block.call(controller)
          end
        end
      end

      def run
        setup!
        setup_deferred_callbacks!
        execute_callbacks(self.before_callbacks)
        execute_controller_callbacks(controller.class.before_callbacks)
        execute
        execute_controller_callbacks(controller.class.after_callbacks)
        execute_callbacks(self.after_callbacks)
      end

    end

  end
end