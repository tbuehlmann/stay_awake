module StayAwake
  module Strategies
    class Httparty
      include Singleton, Strategy

      def available?
        defined?(HTTParty) ? true : false
      end

      def buzz(url)
        require 'timeout'
        StayAwake.logger.info 'Starting buzzing using HTTParty.'

        @thread = Thread.new do
          loop do
            begin
              Timeout.timeout(30) do
                uuid = SecureRandom.uuid
                StayAwake.logger.debug "Starting HTTP Request (#{uuid})."
                HTTParty.send(StayAwake.config.request_method, url)
                StayAwake.logger.debug "HTTP Response arrived (#{uuid})."
                # TODO: Failing request?
              end
            rescue Timeout::Error
              StayAwake.logger.error "HTTP Timeout Error after 30 seconds (#{uuid})."
            rescue StandardError => e
              StayAwake.logger.error e.message
            end

            sleep StayAwake.config.interval
          end
        end
      end

      def shut_off
        @thread.kill
        @thread = nil
        StayAwake.logger.info 'Stopped buzzing.'
      end
    end
  end
end
