require 'fileutils'

module LaunchBase
  class Plugin < Thor
    include Thor::Actions

    def self.method_added(method_sym)
      super unless method_sym == :install
    end

    def touch(file_path)
      full_path = File.join(destination_root, file_path)
      FileUtils.touch(full_path)
    end

    def run_install
      say "Install #{class_name} module"
      install
      say "Successfully installed #{class_name} module"
    end

    def self.install(destination_root:)
      new([], {}, destination_root: destination_root).run_install
    end

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
      to_snake_case(class_name)
    end

    def self.command_line_flag
      "with-#{plugin_name.tr('_', '-')}"
    end

    def class_name
      self.class.class_name
    end

    def self.class_name
      name
        .split('::')
        .last
    end

    def self.to_snake_case(str)
      str
        .gsub(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
    end
  end
end
