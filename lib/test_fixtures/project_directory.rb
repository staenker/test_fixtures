module TestFixtures
  #noinspection RubyClassVariableUsageInspection
  class ProjectDirectory
    def initialize(test_directory_names, code_directory_names)
      @test_directory_names = test_directory_names
      @code_directory_names = code_directory_names
    end

    def guess(test_file, suffix='.rb')
      assert_exists(test_file)
      assert_file(test_file)
      assert_under_test_directory(test_file)
      assert_has_suffix(test_file, suffix)
      project_dir = travel_up_til_one_of_directories_available(Pathname.new(test_file), @test_directory_names + @code_directory_names, 2)
      unless project_dir
        raise "Could not guess project directory from file #{test_file}"
      end
      project_dir
    end

    private
    def travel_up_til_one_of_directories_available(old_pathname, directories, minimal_intersection_size)
      new_pathname = old_pathname.parent
      root_directory_reached = new_pathname == old_pathname
      if root_directory_reached
        return nil
      else
        children = new_pathname.children(false).map { |pathname| pathname.to_path }
        intersection = children & directories
        if intersection.size < minimal_intersection_size
          travel_up_til_one_of_directories_available(new_pathname, directories, minimal_intersection_size)
        else
          new_pathname.to_path
        end
      end
    end

    def assert_exists(test_file)
      unless File.exist?(test_file)
        raise "#{test_file} does not exist"
      end
    end

    def assert_file(test_file)
      unless File.file?(test_file)
        raise "#{test_file} is not a regular file"
      end
    end

    def assert_under_test_directory(test_file)
      file_not_in_known_test_directory = @test_directory_names.select { |test_directory_name| test_file.include?(test_directory_name) }.empty?
      if file_not_in_known_test_directory
        raise "#{test_file} is not stored under any known test directory(#{@test_directory_names.inspect})"
      end
    end

    def assert_has_suffix(test_file, suffix)
      unless test_file.end_with?(suffix)
        raise "#{test_file} is missing suffix #{suffix}. Suffix defaults to .rb but can be overridden by providing it as second argument to guess(test_file, suffix='.rb')"
      end
    end
  end
end
