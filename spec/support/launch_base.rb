module LaunchBaseTestHelpers
  def project_path
    environment_variable = 'DUMMY_APP_PATH'
    dummy_app_path = ENV[environment_variable]

    raise "#{environment_variable} is missing" if dummy_app_path.nil? || dummy_app_path.empty?
    raise "#{environment_variable} #{dummy_app_path} does not exist" unless File.directory?(dummy_app_path)

    dummy_app_path
  end
end
