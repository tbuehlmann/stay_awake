module StayAwake
  module Strategies
    class NetHttp
      include Singleton, Strategy

      def self.available?
        begin
          require 'net/http'
          require 'uri'
          true
        rescue LoadError
          false
        end
      end

      def self.buzz(url)
        require 'timeout'
        StayAwake.logger.info 'Starting buzzing using net/http.'

        @thread = Thread.new do
          loop do
            begin
              Timeout.timeout(30) do
                uuid = SecureRandom.uuid
                StayAwake.logger.debug "Starting HTTP Request (#{uuid})."
                
                uri = URI.parse(url)
                http = Net::HTTP.new(uri.host, uri.port)
                request_method = StayAwake.config.request_method.to_s.capitalize
                request_class = Kernel.const_get("Net::HTTP::#{request_method}")
                response = http.request(request_class.new(uri.request_uri))
                
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

      def self.shut_off
        @thread.kill
        @thread = nil
        StayAwake.logger.info 'Stopped buzzing.'
      end
    end
  end
end
