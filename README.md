# Htmon::Icinga

This gem provides a icinga / nagios compatible client for [timmyArch/htmon](https://github.com/timmyArch/htmon).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'htmon-icinga'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install htmon-icinga

## Usage

It provides an easy to use interface for creating modules.

Normally your module only needs to inherit from Htmon::Icinga::Module.

It will provide you multiple callbacks. 
** The callback should only return a String(*the message*) if condition allows it

* callback :on_ok
* callback :on_warn
* callback :on_crit

Each of these callbacks accept 3 arguments -> ** | value, warn, crit | **
Please checkout [keepalive](https://github.com/timmyArch/htmon/lib/htmon/icinga/modules/keepalive.rb) module.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/timmyArch/htmon-icinga.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

