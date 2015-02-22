module Audit
  module Trail
    Adapters = Module.new

    class Adapter
      NotImplementedError = Class.new(StandardError)
      InvalidContextError = Class.new(StandardError)

      include Audit::Trail::Inflection

      inflecto_reader :name, :namespace

      def initialize(name)
        @name = name.to_s
        @namespace = "Audit::Trail::Adapters::#{name(:camelize)}"
        load_and_init
      end

      def apply_config(context)
        config.each do |remote_name, default_value|
          context.send(
            :add_config_option,
            name: "#{name(:underscore)}_#{remote_name}",
            default_value: default_value
          )
        end
      rescue NoMethodError => e
        raise(
          Audit::Trail::Adapter::InvalidContextError,
          "#{e.message} (#{e.class.name})",
          e.backtrace
        )
      end

      def config
        raise(
          Audit::Trail::Adapter::NotImplementedError,
          "#{namespace}#config must be implemented"
        )
      end

      private

      def load_and_init
        begin
          require_adapter
          singleton_class.send(:prepend, namespace(:constantize))
        rescue => e
          raise(
            Audit::Trail::Config::AdapterError,
            "Failed to load #{name} adapter - #{e.message} (#{e.class.name})",
            e.backtrace
          )
        end
      end

      def require_adapter
        require "audit/trail/adapters/#{name(:underscore)}"
      rescue LoadError
        false
      end
    end
  end
end
