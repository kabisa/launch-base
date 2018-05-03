module LaunchBaseTestHelpers
  def project_path
    environment_variable = 'DUMMY_APP_PATH'
    dummy_app_path = ENV[environment_variable]

    raise "#{environment_variable} is missing" if dummy_app_path.nil? || dummy_app_path.empty?
    raise "#{environment_variable} #{dummy_app_path} does not exist" unless File.directory?(dummy_app_path)

    dummy_app_path
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

  private

  def directory_existence(directory_path)
    File.directory?(project_file_path(directory_path))
  end

  def file_existence(file_path)
    File.exists?(project_file_path(file_path))
  end

  def project_file_path(file_path)
    "#{project_path}/#{file_path}"
  end
end
