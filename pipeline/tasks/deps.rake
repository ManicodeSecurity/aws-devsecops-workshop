require 'bundler/audit/cli'

namespace :commit do
    desc 'Update bundle-audit database'
    task :update do
      Bundler::Audit::Task.new
    end
end