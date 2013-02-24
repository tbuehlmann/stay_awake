module StayAwake
  class Configuration
    include Singleton

    attr_accessor :app_name
    attr_accessor :url
    attr_accessor :request_method
    attr_accessor :interval
    attr_accessor :logger
    attr_accessor :strategy

    def initialize
      @request_method = :head
      @interval = 5*60
      @logger = Logger.new(STDOUT)
      @logger.progname = :stay_awake
      @strategy = StayAwake.strategies
    end
  end

  class ConfigurationError < StandardError; end
end
