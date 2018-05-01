require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module LaunchBase
  # Overwrite certain things in the Rails AppGenerator
  class AppGenerator < Rails::Generators::AppGenerator
    def finish_template
      invoke :launch_base_customization
      super
    end

    def launch_base_customization
      invoke :customize_gemfile
      invoke :setup_development_environment
    end

    def customize_gemfile
      build :replace_gemfile
      build :set_ruby_to_version_being_used
      bundle_command 'install'
    end

    def setup_development_environment
      build :configure_generators
    end

    protected

    def get_builder_class
      LaunchBase::AppBuilder
    end
  end
end
