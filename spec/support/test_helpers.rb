require_relative './file_expectations'

module TestHelpers
  DUMMY_APP_PATH_ENV_VAR_NAME = 'DUMMY_APP_PATH'.freeze
  include FileExpectations

  class TempDirectoryDSL
    include TestHelpers
    include FileExpectations

    def resolve_file_path(file_path)
      temp_test_directory.join(file_path)
    end
  end

  def project_path
    raise "#{DUMMY_APP_PATH_ENV_VAR_NAME} is missing" if dummy_app_path_not_set?
    raise "#{DUMMY_APP_PATH_ENV_VAR_NAME} #{dummy_app_path} does not exist" unless File.directory?(dummy_app_path)

    Pathname.new(dummy_app_path)
  end

  def dummy_app_path_not_set?
    (dummy_app_path || '').empty?
  end

  def within_temp_test_directory(&block)
    FileUtils.rm_rf(temp_test_directory)
    FileUtils.mkdir_p(temp_test_directory)

    FileUtils.cd(temp_test_directory) do
      TempDirectoryDSL.new.instance_eval(&block)
    end
  end

  def temp_test_directory
    root_path.join('tmp', 'launch_base', 'test_space')
  end

  def templates_directory
    root_path.join('templates')
  end

  def invoke_command(*args)
    capture :stdout do
      LaunchBase::CLI.start(args)
    end
  end

  def create_file(file_path, file_contents = '')
    resolve_file_path(file_path).open('w') do |file|
      file.write(file_contents)
    end
  end

  protected

  def root_path
    Pathname.new(__dir__).join('..', '..')
  end

  def dummy_app_path
    ENV[DUMMY_APP_PATH_ENV_VAR_NAME]
  end

  def resolve_file_path(file_path)
    project_path.join(file_path)
  end
end
