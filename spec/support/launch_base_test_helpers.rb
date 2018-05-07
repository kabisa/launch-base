module LaunchBaseTestHelpers
  DUMMY_APP_PATH_ENV_VAR_NAME = 'DUMMY_APP_PATH'.freeze

  def project_path
    raise "#{DUMMY_APP_PATH_ENV_VAR_NAME} is missing" if dummy_app_path_not_set?
    raise "#{DUMMY_APP_PATH_ENV_VAR_NAME} #{dummy_app_path} does not exist" unless File.directory?(dummy_app_path)

    dummy_app_path
  end

  def dummy_app_path_not_set?
    (dummy_app_path || '').empty?
  end

  def expect_file_contents(file_path, expected_contents)
    file_contents = File.read(project_file_path(file_path))
    expect(file_contents).to match(expected_contents)
  end

  def expect_dir_exists(directory_path)
    expect(directory_existence(directory_path)).to be true
  end

  def expect_dir_exists_not(directory_path)
    expect(directory_existence(directory_path)).to be false
  end

  def expect_file_exists(file_path)
    expect(file_existence(file_path)).to be true
  end

  def within_temp_test_directory(&block)
    FileUtils.rm_rf(temp_test_directory)
    FileUtils.mkdir_p(temp_test_directory)
    FileUtils.cd(temp_test_directory, &block)
  end

  def temp_test_directory
    Pathname.new('tmp').join('launch_base', 'test_space')
  end

  def templates_directory
    Pathname.new(__dir__).join('..', '..', 'templates')
  end

  private

  def dummy_app_path
    ENV[DUMMY_APP_PATH_ENV_VAR_NAME]
  end

  def directory_existence(directory_path)
    File.directory?(project_file_path(directory_path))
  end

  def file_existence(file_path)
    File.exist?(project_file_path(file_path))
  end

  def project_file_path(file_path)
    "#{project_path}/#{file_path}"
  end
end
