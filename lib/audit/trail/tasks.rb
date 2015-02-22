module Audit
  module Trail
    class Tasks
      include Rake::DSL if defined? Rake::DSL

      def install_tasks
        namespace :audit do
          namespace :trail do
            desc "start a console with audit-trail loaded"
            task :console do
              require "pry"
              require "audit/trail"
              Pry.start
            end
          end
        end
      end
    end
  end
end

Audit::Trail::Tasks.new.install_tasks
