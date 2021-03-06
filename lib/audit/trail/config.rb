module Audit
  module Trail
    class Config
      AdapterError = Class.new(StandardError)

      attr_reader :adapter

      def initialize(adapter: default_adapter)
        self.adapter = adapter
      end

      def adapter=(name)
        @adapter = Audit::Trail::Adapter.new(name)
        @adapter.apply_config(self)
        adapter
      end

      def to_hsh
        {}.tap { |config|
          config[:adapter] = adapter.namespace
          adapter.config.each do |attr, _|
            cvar = adapter.config_var(attr)
            config[cvar.to_sym] = send(cvar)
          end
        }
      end
      alias :to_h :to_hsh

      private

      def add_config_option(name:, default_value:)
        singleton_class.send(:define_method, name) do
          ivar = instance_variable_get("@#{name}")
          ivar ? ivar : default_value
        end

        singleton_class.send(:attr_writer, name)
      end

      def default_adapter
        :redis
      end
    end
  end
end
