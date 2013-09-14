require 'test_fixtures/directory'
require 'spec_helper'

module TestFixtures
  describe Directory do
    context 'working directly with fixture files' do
      let(:subject) { Directory.new(nil) }

      it 'should return the path to the fixture directory' do
        directory = subject.from_test_file(__FILE__)
        directory.should eql "#{File.dirname(__FILE__)}/directory_spec-fixture"
      end

      it 'should handle multiple fixtures for one test file' do
        directory1 = subject.from_test_file(__FILE__, 'fixture_a')
        directory2 = subject.from_test_file(__FILE__, 'fixture_b')
        directory1.should eql "#{File.dirname(__FILE__)}/directory_spec-fixtures/fixture_a"
        directory2.should eql "#{File.dirname(__FILE__)}/directory_spec-fixtures/fixture_b"
      end
    end

    context 'working with a copy of fixture files' do
      let(:subject) {
        tmp = File.join(File.dirname(__FILE__), 'directory_spec-fixtures')
        unless File.exist?(tmp)
          Dir.mkdir(tmp)
        end
        Directory.new(tmp)
      }

      it 'should return the path to the fixture directory' do
        directory = nil
        subject.temp_copy_from_test_file(__FILE__) do |tmp|
          File.exist?(tmp).should be true
          File.directory?(tmp).should be true
          File.read(File.join(tmp, 'hello.txt')).should eql "Hello\n"
          File.read(File.join(tmp, 'world.txt')).should eql "World\n"
          directory = tmp
        end
        File.exist?(directory).should be false
        File.directory?(directory).should be false
        directory.should end_with('/directory_spec-fixture')
        directory.should_not eql directory = subject.from_test_file(__FILE__)
      end

      it 'should handle multiple fixtures for one test file' do
        directory = nil
        subject.temp_copy_from_test_file(__FILE__, 'fixture_a') do |tmp|
          File.exist?(tmp).should be true
          File.directory?(tmp).should be true
          File.read(File.join(tmp, 'you.txt')).should eql "You\n"
          File.read(File.join(tmp, 'are.txt')).should eql "Are\n"
          directory = tmp
        end
        File.exist?(directory).should be false
        File.directory?(directory).should be false
        directory.should end_with('/fixture_a')
        directory.should_not eql directory = subject.from_test_file(__FILE__, 'fixture_a')
      end
    end
  end
end
