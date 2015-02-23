module Audit
  module Trail
    class Recorder
      attr_reader :config

      def initialize(config: false)
        self.config = config
      end

      def record(erb_str, data: {})
        save(Record.new(erb_str, data: data).to_record)
      end

      private

      def config=(obj)
        @config = load_config(obj)
      end

      def load_config(obj)
        if obj.is_a?(Audit::Trail::Config)
          obj
        elsif obj.is_a?(Hash) && obj.has_key?(:adapter)
          Audit::Trail::Config
            .new(:adapter => obj.delete(:adapter))
            .tap { |config|
              obj.each do |attr, value|
                setter = "#{attr}="
                config.send(setter, value) if config.respond_to?(setter)
              end
            }
        elsif defined?(AUDIT_TRAIL_CONFIG)
          load_config(AUDIT_TRAIL_CONFIG)
        elsif ENV.has_key?("AUDIT_TRAIL_CONFIG")
          load_config(ENV.fetch("AUDIT_TRAIL_CONFIG"))
        else
          Audit::Trail::Config.new
        end
      end

      def save(record)
        record # TODO: use config.adapter.store(record)
      end
    end
  end
end
