module StayAwake
  module Strategy
    def self.included(base)
      StayAwake.strategies << base
      base.extend ClassMethods
    end

    module ClassMethods
      def available?(*args)
        raise NotImplementedError
      end

      def buzz(*args)
        raise NotImplementedError
      end

      def shut_off(*args)
        raise NotImplementedError
      end
    end
  end
end
