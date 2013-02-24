require 'logger'
require 'securerandom'
require 'singleton'

module StayAwake
  def self.config
    Configuration.instance
  end

  def self.configure(&block)
    yield config
    self
  end

  def self.logger
    config.logger
  end

  def self.strategies
    @strategies ||= []
  end

  def self.buzz
    Buzzer.instance.buzz
  end

  def self.buzzing?
    Buzzer.instance.buzzing?
  end

  def self.shut_off
    Buzzer.instance.shut_off
  end

  require 'stay_awake/buzzer'
  require 'stay_awake/configuration'
  require 'stay_awake/strategy'
  require 'stay_awake/version'

  module Strategies
    require 'stay_awake/strategies/em_http_request'
    require 'stay_awake/strategies/httparty'
    require 'stay_awake/strategies/net_http'
  end
end
