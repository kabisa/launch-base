module LaunchBaseTestHelpers

  def create_tmp_directory
    FileUtils.mkdir_p(tmp_directory)
  end

  def remove_tmp_directory
    Dir.chdir(tmp_directory)
    Dir.chdir("..")
    FileUtils.rm_rf("launch_base")
  end

  def tmp_directory
    "#{ENV["HOME"]}/tmp/launch_base"
  end

  def app_name
    'awesome_app'
  end

  def project_path
    File.expand_path("#{tmp_directory}/#{app_name}")
  end

  def generate_new_app
    create_tmp_directory
    `bin/launch_base #{project_path}`
  end

  def remove_generated_app
    Dir.chdir tmp_directory
    `rm -rf #{project_path}`
  end
end