require 'tmpdir'

module TestFixtures
  class Directory
    def initialize(project_directory)
      @project_directory = project_directory
    end

    def from_test_file(file, fixture_name=nil)
      fixture_dir_base = File.join(File.dirname(file), spec_name(file))
      if fixture_name
        File.join("#{fixture_dir_base}-fixtures", fixture_name)
      else
        "#{fixture_dir_base}-fixture"
      end
    end

    def temp_copy_from_test_file(file, fixture_name=nil)
      fixture_source = from_test_file(file, fixture_name)
      prefix_suffix = spec_name(file)
      tmp_dir_base = File.join(@project_directory, 'tmp')
      unless File.exist?(tmp_dir_base)
        Dir.mkdir(tmp_dir_base)
      end
      Dir.mktmpdir(prefix_suffix, tmp_dir_base) do |tmp_dir|
        FileUtils.cp_r(fixture_source, tmp_dir)
        yield(File.join(tmp_dir, File.basename(fixture_source)))
      end
    end

    private
    def spec_name(file)
      File.basename(file, '.rb')
    end

  end
end
