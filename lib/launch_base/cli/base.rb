require 'thor'
require 'launch_base/cli/all'
require 'launch_base/utilities'

module LaunchBase
  module CLI
    class Base < Thor
      include Thor::Actions

      package_name 'launch_base'
      register(CLI::Lint, 'lint', 'lint', 'Lint commands')
      register(CLI::Add, 'add', 'add', 'Add additional modules')

      desc 'update', "update #{LaunchBase}"
      long_desc <<-LONGDESC
        `#{@package_name} update` triggers Bundler to update the #{LaunchBase} gem
      LONGDESC
      def update
        run 'bundle update launch_base --conservative'
      end

      desc 'new', "Create a new #{LaunchBase} project"
      long_desc <<-LONGDESC
        `#{@package_name} new [project-path]` creates a new rails project with Kabisa preferences.
      LONGDESC
      def new(project_path)
        installed_rails_version = Utilities.get_rails_version

        if installed_rails_version
          if Utilities.rails_up_to_date?(installed_rails_version)
            run "rails new #{project_path} -m #{Utilities.gem_home}/templates/launch_base_default_template.rb"
          else
            say "Your current installation of Rails is outdated (#{installed_rails_version}). "\
                "Please upgrade to Rails #{RAILS_VERSION}"
          end
        else
          say "No installation of Rails found. Please install Rails #{RAILS_VERSION}"
        end
      end

      def help
        show_banner
        super
      end

      private

      def show_banner
        say "\u{1f680} Kabisa #{LaunchBase}\n\n"
      end
    end
  end
end
