module LaunchBase
  class AppBuilder < Rails::AppBuilder

    def gemfile
      template "Gemfile.erb", "Gemfile"
    end

    def replace_gemfile
      template 'Gemfile.erb', 'Gemfile', force: true
    end

    def set_ruby_to_version_being_used
      create_file '.ruby-version', "#{LaunchBase::RUBY_VERSION}\n", force: true
    end

    def configure_generators
      config = <<-RUBY

      config.generators do |generate|
        generate.test_framework :rspec
      end

      RUBY

      inject_into_class 'config/application.rb', 'Application', config
    end
  end
end
