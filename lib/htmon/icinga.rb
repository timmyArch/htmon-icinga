require 'redis'
require "htmon/icinga/version"
require "htmon/icinga/module"

module Htmon
  module Icinga
  
    def self.redis
      @redis
    end

    def self.redis= r 
      @redis = r
    end
  
  end
end
