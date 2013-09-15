require 'test_fixtures'
require 'rspec'

describe TestFixtures do
  it 'will provide you with the projects root directory' do
    project_root_directory = TestFixtures.project_root_directory(__FILE__)
    project_root_directory.should eql Pathname.new(__FILE__).parent.parent.to_path
  end

  it 'will provide you with the projects temporary directory' do
    project_root_directory = TestFixtures.project_tmp_directory(__FILE__)
    project_root_directory.should eql File.join(Pathname.new(__FILE__).parent.parent.to_path, 'tmp')
  end

  it 'will provide you with a spec specific fixture directory' do
    fixture_directory = TestFixtures.fixture_dir(__FILE__)
    fixture_directory_by_convention = File.join(File.dirname(__FILE__), 'use_cases_spec-fixture')
    fixture_directory.should eql fixture_directory_by_convention
  end

  it 'will provide you with a spec specific fixtures directory' do
    fixture_directory = TestFixtures.fixture_dir(__FILE__, 'fixture_a')
    fixture_directory_by_convention = File.join(File.dirname(__FILE__), 'use_cases_spec-fixtures', 'fixture_a')
    fixture_directory.should eql fixture_directory_by_convention
  end

  it 'will provide you with a temporary, spec specific working copy of a fixture directory' do
    temporary_directory = nil
    TestFixtures.tmp_copy_of_fixture_dir(__FILE__) do |fixture_directory|
      fixture_pathname = Pathname.new(fixture_directory)
      fixture_pathname.children(false).map{|pathname| pathname.to_path}.should match_array %w(hello.txt world.txt)
      temporary_directory = fixture_pathname.parent
    end
    File.exist?(temporary_directory).should be false
  end

  it 'will provide you with a temporary, spec specific working copy of a fixtures directory' do
    temporary_directory = nil
    TestFixtures.tmp_copy_of_fixture_dir(__FILE__, 'fixture_a') do |fixture_directory|
      fixture_pathname = Pathname.new(fixture_directory)
      fixture_pathname.children(false).map{|pathname| pathname.to_path}.should match_array %w(you.txt are.txt)
      temporary_directory = fixture_pathname.parent
    end
    File.exist?(temporary_directory).should be false
  end

end
