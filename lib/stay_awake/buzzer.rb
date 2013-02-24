module StayAwake
  class Buzzer
    include Singleton

    def initialize
      @buzzing = false
      @strategy = nil
    end

    def buzzing?
      @buzzing
    end

    def buzz
      unless buzzing?
        if StayAwake.config.url
          url = StayAwake.config.url
        elsif StayAwake.config.app_name
          url = "http://#{StayAwake.config.app_name}.herokuapp.com/"
        else
          raise ConfigurationError.new('config.url or config.app_name needed.')
        end

        start_buzzing(url)
        @buzzing = true
      end
    end

    def shut_off
      @strategy.shut_off if buzzing?
      @buzzing = false
    end

    private

    def start_buzzing(url)
      strategies = [StayAwake.config.strategy].flatten
      @strategy = strategies.select(&:available?).first

      if @strategy
        @strategy.buzz(url)
      else
        raise ConfigurationError.new('No valid Strategy given.')
      end
    end
  end
end
