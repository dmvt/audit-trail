require "inflecto"

module Audit
  module Trail
    module Inflection
      def self.included(descendent)
        descendent.send(:extend, ClassMethods)
      end

      module ClassMethods
        def inflecto_reader(*attrs)
          attrs.each do |attr|
            define_method attr do |inflection = nil|
              ivar = instance_variable_get("@#{attr}")
              if inflection && ivar.is_a?(String)
                Inflecto.send(inflection, ivar)
              else
                ivar
              end
            end
          end
        end
      end
    end
  end
end
