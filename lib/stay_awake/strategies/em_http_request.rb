module StayAwake
  module Strategies
    class EmHttpRequest
      include Singleton, Strategy

      def available?
        defined?(EventMachine::HttpRequest) ? true : false
      end

      def buzz(url)
        StayAwake.logger.info 'Starting buzzing using EventMachine::HttpRequest.'

        EM.next_tick do
          @timer = EM::PeriodicTimer.new(StayAwake.config.interval) do
            uuid = SecureRandom.uuid
            request = EventMachine::HttpRequest.new(url)
            StayAwake.logger.debug "Starting HTTP Request (#{uuid})."
            request = request.send(StayAwake.config.request_method)

            request.callback do
              StayAwake.logger.debug "HTTP Response arrived (#{uuid})."
            end

            request.errback do
              StayAwake.logger.error "HTTP Request failed (#{uuid})."
            end

            # TODO: Timeout?
          end
        end
      end

      def shut_off
        @timer.cancel
        @timer = nil
        StayAwake.logger.info 'Stopped buzzing.'
      end
    end
  end
end
