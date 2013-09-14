require 'spec_helper'

describe 'Assumptions' do
  context Array do
    it 'should returns empty array if block never evaluated to tru' do
      array = %w(hello world)
      array.select { |_| false }.should match_array []
    end

    it 'should return an empty array for set intersection in case of no common elements' do
      ([] & []).should match_array []
      ([] & %w(hello world)).should match_array []
      (%w(hello world) & []).should match_array []
      (%w(hello world) & %w(you are so beautiful)).should match_array []
    end
  end

  context Pathname do
    it 'should not return the same pathname if there is no parent directory' do
      start = Pathname.new('/')
      start.parent.should_not be start
    end

    it 'should return an equal pathname if there is no parent directory' do
      start = Pathname.new('/')
      start.parent.should eql start
    end

    it 'should not return an equal pathname if there is a parent directory' do
      start = Pathname.new(__FILE__)
      start.parent.should_not eql start
    end

    it 'should return the parent directory of a file' do
      Pathname.new(__FILE__).parent.to_path.should end_with('/test_fixtures/spec')
    end

    it 'should return the parent directory of a directory' do
      Pathname.new(File.join(File.dirname(__FILE__), 'test_fixtures')).parent.to_path.should end_with('/test_fixtures/spec')
    end
  end
end
