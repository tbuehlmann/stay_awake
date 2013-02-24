# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'stay_awake/version'

Gem::Specification.new do |spec|
  spec.name          = 'stay_awake'
  spec.version       = StayAwake::VERSION
  spec.authors       = ['Tobias Bühlmann']
  spec.email         = ['tobias.buehlmann@gmx.de']
  spec.description   = "Requests websites so they won't fall asleep. Like on Heroku."
  spec.summary       = "stay_awake requests websites like Heroku so they won't fall asleep. It supports the HTTP libraries em-http-request, HTTParty and net/http."
  spec.homepage      = 'https://github.com/tbuehlmann/stay_awake'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.2'
  spec.add_development_dependency 'em-http-request', '~> 1.0'
  spec.add_development_dependency 'httparty', '~> 0.10'
end
