module MissionControl
  module Projects
    module DSL
      module ClassMethods
        def description(value = nil)
          define_method :description do
            block_given? ? yield(self.class) : value
          end
        end

        def show_in_overview(value = nil)
          define_method :show_in_overview? do
            block_given? ? yield(self.class) : value
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end
    end
  end
end