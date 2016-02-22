
module Htmon
  module Icinga
    class Module
      class Filesystemusage < Module
        
        Value ||= Struct.new(:name, :usage)

        callback :handle_value do |value, metric|
          Value.new(metric.split("::").last, value.to_i)
        end

        callback :on_ok do |value, warn, thresh|
          if value.usage < (thresh || warn || 85)
            out = [value.usage, (warn || 85), (thresh || 95)].map do |x|
              "#{x}%"
            end.join(';')
            "Filesystem usage for #{value.name.inspect} (#{value.usage}%) is ok "+
              "| usage=#{out}"
          end
        end

        callback :on_warn do |value, warn, thresh|
          if value.usage < (thresh || 95)
            out = [value.usage, (warn || 85), (thresh || 95)].map do |x|
              "#{x}%"
            end.join(';')
            "Filesystem usage for #{value.name.inspect} (#{value.usage}%) is disturbing "+
              "| usage=#{out}"
          end
        end
        
        callback :on_crit do |value, warn, thresh|
          if value.usage >= (thresh || 95)
            out = [value.usage, (warn || 85), (thresh || 95)].map do |x|
              "#{x}%"
            end.join(';')
            "Filesystem usage for #{value.name.inspect} (#{value.usage}%) is critical "+
              "| usage=#{out}"
          end
        end

      end
    end
  end
end
