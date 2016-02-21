
module Htmon
  module Icinga
    class Module
      class Load < Module
        
        Value ||= Struct.new(:avg1,:avg5,:avg15)

        callback :handle_value do |value, metric|
          Value.new(*metric.split("::").last.to_s.split(','))
        end

        callback :on_ok do |value, warn, thresh|
          if value.avg5 < warn.to_i
            "Load values are #{value.avg1}, #{value.avg5}, #{value.avg1}"+
              "| avg1=#{value.avg1} avg5=#{value.avg5},#{warn.to_i} avg15=#{value.avg15}"
          end
        end

        callback :on_warn do |value, warn, thresh|
          if value.avg5 >= warn.to_i
            "Load values are #{value.avg1}, #{value.avg5}, #{value.avg1}"+
              "| avg1=#{value.avg1} avg5=#{value.avg5},#{warn.to_i} avg15=#{value.avg15}"
          end
        end

      end
    end
  end
end
