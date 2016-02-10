require 'redis'
require 'active_support/all'
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
