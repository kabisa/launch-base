module LaunchBase
  class Plugin < Thor
    include Thor::Actions

    def self.description
      to_s
    end

    def self.inherited(child_class)
      plugin_name = child_class.plugin_name
      register(plugin_name, child_class)
    end

    def self.register(name, plugin)
      @plugins ||= {}
      @plugins[name] = plugin
    end

    def self.each_plugin(&block)
      @plugins.each(&block)
    end

    def self.plugin_name
      name
        .split('::')
        .last
        .gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
    end
  end
end
