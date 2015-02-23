require "erb"
require "digest/md5"
require "set"

module Audit
  module Trail
    class Record
      attr_reader :data, :template

      def initialize(template, data:)
        @data = data
        @template = template
      end

      def checksum
        Digest::MD5.hexdigest(template)
      end

      def to_ary
        to_h.to_a
      end
      alias :to_a :to_ary

      def to_hsh
        {
          :checksum => checksum,
          :data => data,
          :template => template,
          :string => to_s
        }
      end
      alias :to_h :to_hsh
      alias :[] :to_hsh

      def to_record
        (data.is_a?(Hash) ? data.clone : {:data => data}).tap { |record|
          record[:_string] = to_s
          record[:_checksum] = checksum
        }
      end

      def to_s
        ERB.new(@template, nil, "-").result(data)
      end
    end
  end
end
