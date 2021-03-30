# frozen_string_literal: true

require 'bundler/audit/cli'

namespace :bundler do
    desc 'Update bundle-audit database'
    task :bundle_test do
      puts 'Capacity test acceptance environment'
      Bundler::Audit::Task.new
    end
end