require "launch_base/plugin"

module LaunchBase
  module Plugins
    class Sidekiq < Plugin
      def install
        append_to_file 'Gemfile', "gem 'sidekiq', '~> 5.1'"
        append_to_file 'Procfile', 'bundle exec sidekiq'
        empty_directory 'app/workers'
        run 'bundle install'
      end
    end
  end
end
