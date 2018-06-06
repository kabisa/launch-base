require 'launch_base/plugin'
require 'launch_base/plugins/all'

module LaunchBase
  module CLI
    class Add < Thor
      Plugin.each_plugin do |plugin_name, plugin|
        desc plugin_name, "Adds #{plugin.description} to the Rails app"
        long_desc "#{@package_name} add #{plugin_name} adds #{plugin.description} to the Rails app"

        define_method(plugin_name) do
          plugin.new.install
        end
      end
    end
  end
end
