
module Htmon
  module Icinga
    class Module
      class Packages < Module
        
        callback :on_ok do |value, warn, thresh|
          if value.to_i < warn.to_i
            "#{value.to_i} packages are out of date."+
              "| packages=#{value.to_i};#{warn.to_i}"
          end
        end
        
        callback :on_warn do |value, warn, thresh|
          if value.to_i >= warn.to_i
            "#{value.to_i} packages are out of date, update needed."+
              "| packages=#{value.to_i};#{warn.to_i}"
          end
        end

      end
    end
  end
end
