module LaunchBase
  module Utilities
    def self.rails_up_to_date?(installed_rails_version)
      Gem::Dependency.new('rails', RAILS_VERSION) =~ Gem::Dependency.new('rails', installed_rails_version)
    end

    def self.get_rails_version
      output = `rails -v 2>&1`
      match_data = /Rails ([0-9.]+)/.match(output)

      match_data[1] if match_data
    end

    def self.gem_home
      Pathname.new(__dir__).join('..', '..')
    end
  end
end
