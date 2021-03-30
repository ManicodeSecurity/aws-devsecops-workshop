# frozen_string_literal: true

namespace :commit do
  desc 'Static analysis tests'
  task static_analysis: [:rubocop]
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ['--fail-level F']
  end
rescue LoadError
  puts "Unable to load rubocop/rake_task, rubocop tests missing\n"
end
