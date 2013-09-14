require 'test_fixtures/project_directory'
require 'spec_helper'

module TestFixtures
  describe ProjectDirectory do
    context 'working setup' do
      let(:subject) { ProjectDirectory.new(%w(spec test), %w(bin app config db lib Gemfile)) }

      it 'should return the path to the projects root directory' do
        project_directory = subject.guess(__FILE__)
        project_directory.should eql "#{Pathname.new(__FILE__).parent.parent.parent.to_path}"
      end
    end

    context 'error cases' do
      it 'will fail if cannot find a root directory' do
        expect do
          subject = ProjectDirectory.new(%w(spec test), %w(app config db))
          project_directory = subject.guess(__FILE__)
          project_directory.should eql "#{Pathname.new(__FILE__).parent.parent.parent.to_path}"
        end.to raise_error(RuntimeError, /Could not guess project directory from file .+project_directory_spec\.rb/)
      end
    end
  end
end
