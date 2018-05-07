require 'thor'

module LaunchBase
  class LintCLI < Thor
    include Thor::Actions

    desc 'install', 'install lint configuration files'
    long_desc <<-LONGDESC
      `#{@package_name} lint install` installs the lint configuration files into the current directory
    LONGDESC
    def install
      ['.codeclimate.yml', '.eslintrc.json', '.mdlrc', '.rubocop.yml', 'config.reek'].each do |config_file_name|
        create_file(config_file_name) do
          gem_home.join('templates', config_file_name).read
        end
      end
    end

    desc 'update', 'update lint configuration files'
    long_desc <<-LONGDESC
      `#{@package_name} lint update` updates the gem and installs the lint configuration files
    LONGDESC
    def update
      invoke CLI, 'update'
      invoke :install
    end

    private

    def gem_home
      Pathname.new(__dir__).join('..', '..')
    end
  end
end
