
module Htmon
  module Icinga
    class Module
      class Packages < Module

        Value ||= Struct.new(:name, :amount)

        callback :handle_value do |value, metric|
          Value.new(metric.split("::").last, value.to_i)
        end
        
        callback :on_ok do |value, warn, thresh|
          if value.amount < warn.to_i
            "#{value.amount} (#{value.name}) packages are out of date."+
              "| packages=#{value.amount};#{warn.to_i}"
          end
        end
        
        callback :on_warn do |value, warn, thresh|
          if value.amount >= warn.to_i
            "#{value.amount} (#{value.name}) packages are out of date, update needed."+
              "| packages=#{value.amount};#{warn.to_i}"
          end
        end

      end
    end
  end
end
