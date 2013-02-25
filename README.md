# stay_awake

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
| `strategy` | `StayAwake::Strategy` | `StayAwake.strategies` |

You can either use `app_name` or `url`, but `url` has precedence over `app_name`. If just `app_name` is given, it will be translated to `http://app_name.herokuapp.com/`.

When using em-http-request, the buzzing will begin on the `next_tick`.

### Supported HTTP Libraries
- [em-http-request](https://github.com/igrigorik/em-http-request "em-http-request")
- [HTTParty](https://github.com/jnunemaker/httparty "HTTParty")
- [net/http](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/index.html "net/http")
