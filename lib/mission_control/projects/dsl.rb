module MissionControl
  module Projects
    module DSL
      module ClassMethods
        def description(value = nil)
          define_method :description do
            block_given? ? yield(self.class) : value
          end
        end

        def visible(value = nil)
          define_method :visible? do
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