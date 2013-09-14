project_dir = File.dirname(__FILE__)
require 'bundler/gem_tasks'

require 'rake/clean'
tmp_dir = File.join(project_dir, 'spec', 'test_fixtures', 'directory_spec-fixtures', 'tmp')
CLEAN.include([tmp_dir, 'pkg'])

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
