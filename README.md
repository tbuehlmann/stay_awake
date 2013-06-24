# stay_awake [![Gem Version](https://badge.fury.io/rb/stay_awake.png)](http://badge.fury.io/rb/stay_awake) [![Dependency Status](https://gemnasium.com/tbuehlmann/stay_awake.png)](https://gemnasium.com/tbuehlmann/stay_awake)

## About
stay_awake requests websites periodically. It's written especially for Heroku, that puts applications to sleep when there are no requests coming in.

## Installation
### Gem
    $ gem install stay_awake
### Bundler
```ruby
gem 'stay_awake'
```
### Bundler (head)
```ruby
gem 'stay_awake', :github => 'tbuehlmann/stay_awake'
```

## Usage
```ruby
buzzer = StayAwake.configure do |c|
  c.app_name = 'app_name'
end

buzzer.buzz
```

### Sinatra
Put the `StayAwake.configure` block inside Sinatra's `configure` block, run `buzz` and you're done:

```ruby
# app.rb

class App < Sinatra::Base
  configure :production do
    StayAwake.configure do |c|
      c.app_name = 'app_name'
    end.buzz
  end

  # …
end
```

### Rails
Put the `StayAwake.configure` block inside an initializer, run `buzz` and you're done:

```ruby
# config/initializers/stay_awake.rb

if Rails.env.production?
  StayAwake.configure do |c|
    c.app_name = 'app_name'
  end.buzz
end
```

### Configuration Defaults
| Configuration | Type | Default |
|:-:|:-:|:-:|
| `app_name` | `String` | `nil` |
| `url` | `string` | `nil`|
| `request_method` | `Symbol` | `:head` |
| `interval` | `Integer` | `300` |
| `logger` | `Logger` | `Logger.new(STDOUT)` |
| `strategy` | `Class` | `StayAwake.strategies` |

You can either use `app_name` or `url`, but `url` has precedence over `app_name`. If just `app_name` is given, it will be translated to `http://app_name.herokuapp.com/`.

`strategy` takes a single Class or Array of Classes that mixed in the `Strategy` Module. If an Array is given, each Strategy is tested for availability. The first available Strategy will be used for buzzing.

When using EM-HTTP-Request, the buzzing will begin on the `next_tick`. When using httparty or Net::HTTP, buzzing will begin immediately (using a Thread).

### Supported HTTP Libraries
- [EM-HTTP-Request](https://github.com/igrigorik/em-http-request "EM-HTTP-Request")
- [httparty](https://github.com/jnunemaker/httparty "httparty")
- [Net::HTTP](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/index.html "Net::HTTP")
