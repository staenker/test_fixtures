require 'test_fixtures/version'
require 'test_fixtures/directory'
require 'test_fixtures/project_directory'

#noinspection RubyClassVariableUsageInspection
module TestFixtures
  @@project_directory = ProjectDirectory.new(%w(test spec), %w(bin lib app db config))

  def self.fixture_dir(test_file, fixture_name=nil)
    directory_instance(test_file).from_test_file(test_file, fixture_name)
  end

  def self.tmp_copy_of_fixture_dir(test_file, fixture_name=nil, &block)
    directory_instance(test_file).temp_copy_from_test_file(test_file, fixture_name, &block)
  end

  def self.project_root_directory(test_file)
    @@project_directory.guess(test_file)
  end

  def self.project_tmp_directory(test_file)
    tmp = File.join(project_root_directory(test_file), 'tmp')
    unless File.exist?(tmp)
      Dir.mkdir(tmp)
    end
    tmp
  end

  def self.project_directory=(project_directory)
    @@project_directory = project_directory
  end

  private
  def self.directory_instance(test_file)
    project_directory_guess = @@project_directory.guess(test_file)
    Directory.new(project_directory_guess)
  end
end
