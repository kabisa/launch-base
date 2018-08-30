require 'thor'

module LaunchBase
  module CLI
    class Lint < Thor
      include Thor::Actions

      desc 'install', 'install lint configuration files'
      long_desc <<-LONGDESC
        `#{@package_name} lint install` installs the lint configuration files into the current directory
      LONGDESC
      def install
        ['.codeclimate.yml', '.eslintrc.json', '.mdlrc', '.rubocop.yml', 'config.reek'].each do |config_file_name|
          create_file(config_file_name) do
            Utilities.gem_home.join('templates', config_file_name).read
          end
        end
      end

      desc 'update', 'update gem and reinstall lint configuration files'
      long_desc <<-LONGDESC
        `#{@package_name} lint update` updates the gem and reinstalls the lint configuration files
      LONGDESC
      def update
        invoke Base, 'update'
        invoke :install
      end
    end
  end
end
