
module Htmon
  module Icinga
    class Module
      class Process < Module
        
        Value ||= Struct.new(:amount,:name)

        callback :handle_value do |value, metric|
          Value.new(value.to_i, metric.split("::").last)
        end

        callback :on_ok do |value, warn, thresh|
          if value.amount > 0
            "Process #{value.name.inspect} are #{value.amount} times present "+
              "| signals=#{value.amount}"
          end
        end

        callback :on_crit do |value, warn, thresh|
          "Process #{value.name.inspect} not running" unless value.amount > 0
        end

      end
    end
  end
end
