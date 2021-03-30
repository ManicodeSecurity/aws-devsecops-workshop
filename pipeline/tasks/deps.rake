require 'bundler/audit/cli'

namespace :commit do
    desc 'Update bundle-audit database'
    task :update do
      Bundler::Audit::CLI.new.update
    end

    desc 'Check gems for vulns using bundle-audit'
    task :check do
      Bundler::Audit::CLI.new.check
    end

    desc 'Update vulns database and check gems using bundle-audit'
    task :run do
      Rake::Task['commit:update'].invoke
      Rake::Task['commit:check'].invoke
    end
  end

  task :bundle_audit do
    Rake::Task['commit:run'].invoke
  end