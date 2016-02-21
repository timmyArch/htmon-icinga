
module Htmon
  module Icinga
    class Module
      class Packages < Module
        
        callback :on_ok do |value, warn, thresh|
          if value.amount < warn.to_i
            "#{value} packages are out of date."+
              "| packages=#{value.amount}"
          end
        end
        
        callback :on_warn do |value, warn, thresh|
          if value.amount >= warn.to_i
            "#{value} packages are out of date, update needed."+
              "| packages=#{value.amount},#{warn.to_i}"
          end
        end

      end
    end
  end
end
