
module Htmon
  module Icinga

    def self.new hostname: nil, metric: nil, thresh: nil, warn: nil, redis: nil
      a = Module.modules.find do |x|
        x.metric_name.to_s == metric.to_s[/^[^:]+/]
      end
      if a
        a.new(hostname: hostname, thresh: thresh, warn: warn, 
              redis: redis, metric: metric)
      else
        raise "No module found"
      end
    end


    class Module

      Result ||= Struct.new(:message, :level)

      Result.class_eval do 

        def print
          send(level, self.message)
        end

        private

        def die code, message
          puts message
          exit code
        end

        def ok message
          die 0, message
        end

        def warn message
          die 1, message
        end

        def crit message
          die 2, message
        end
        
        def unknown message
          die 2, message
        end

      end

      class << self

        attr_accessor :metric_name
        attr_reader :callbacks, :performance_data

        def modules
          @modules ||= []
        end

        def inherited klass
          modules << klass
        end

        def metric_name
          @metric_name || name.gsub(/^Htmon::Icinga::Module::/, '').underscore
        end

        def callback method, &block
          @callbacks ||= {}
          if block_given?
            @callbacks[method] = block
          else
            @callbacks[method]
          end
        end

      end

      attr_accessor :hostname, :thresh, :warn, :redis, :metric

      def initialize hostname: nil, thresh: nil, warn: nil, redis: nil, metric: nil
        @hostname, @thresh, @warn, @redis, @metric = hostname, thresh, warn, redis, metric
      end

      def redis
        @redis || Icinga.redis
      end

      def result
        hv = self.class.callbacks[:handle_value]
        post_value = hv ? hv.call(value, self.metric) : value 
        %i{on_ok on_warn on_crit}.map do |type|
          c = self.class.callbacks[type]
          ret = Result.new
          message = c && c.call(post_value, warn, thresh)
          if message
            ret.level = type.to_s.gsub('on_', '')
            ret.message = message
            ret
          else
            nil
          end
        end.find{|x| x.instance_of? Result } or 
          Result.new("unexpect situation occured", :unknown)
      end

      def value
        @value ||= redis.get "metric::#{hostname}::#{self.metric}"
      end

    end
  end
end

require_relative 'modules/keepalive'
require_relative 'modules/process'

