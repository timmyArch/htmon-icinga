
module Htmon
  module Icinga
    class Module
      class Keepalive < Module
      
        callback :on_ok do |value, warn, thresh|
          if value.to_i > 0
            "Keepalive received #{value} times | signals=#{value}"
          end
        end

        callback :on_crit do |value, warn, thresh|
          "Keepalive not received" if value.nil?
        end

        performance_data do |value|
          "signals=#{value}"
        end

      end
    end
  end
end
