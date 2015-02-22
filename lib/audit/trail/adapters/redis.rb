module Audit
  module Trail
    module Adapters
      module Redis
        def config
          {
            endpoint: "localhost:6379"
          }
        end
      end
    end
  end
end
