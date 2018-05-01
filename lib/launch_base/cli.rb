require 'thor'

module LaunchBase
  class CLI < Thor
    include Thor::Actions
    package_name 'launch_base'

    desc 'update', "update #{LaunchBase}"
    long_desc <<-LONGDESC
      `#{@package_name} update` triggers Bundler to update the #{LaunchBase} gem
    LONGDESC
    def update
      run 'bundle update launch_base'
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
