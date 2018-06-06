describe LaunchBase::CLI do
  describe 'new' do
    it 'generates a new app using the template' do
      stub_installed_rails_version('Rails 5.2.0')
      expect_any_instance_of(LaunchBase::CLI).to receive(:run).with(/rails new foobar.+launch_base_default_template.rb/)

      invoke_command 'new', 'foobar'
    end

    context 'when passing --with-sidekiq' do
      it 'installs sidekiq' do
        stub_installed_rails_version('Rails 5.2.0')
        expect_any_instance_of(cli_base_class).to receive(:run).with(/rails new/)
        expect_any_instance_of(LaunchBase::Plugins::Sidekiq).to receive(:install)

        invoke_command 'new', 'foobar', '--with-sidekiq'
      end
    end

    context 'when no installation of rails can be found' do
      it 'shows a warning rails should be installed' do
        stub_installed_rails_version('')

        output = invoke_command 'new', 'foobar'

        expect(output).to match(/no.+rails.+found.+please.+install.+rails.+5\.2\.0/i)
      end
    end

    context 'the installation of rails is outdated' do
      it 'shows a warning rails should be updated' do
        stub_installed_rails_version("Rails 5.1.3\n")

        output = invoke_command 'new', 'foobar'

        expect(output).to match(/rails.+outdated.+please.+upgrade.+5\.2\.0/i)
      end
    end
  end

  describe 'add' do
    it 'adds Sidekiq' do
      expect_any_instance_of(LaunchBase::Plugin).to receive(:run).with('bundle install')

      within_temp_test_directory do
        create_file 'Gemfile'
        create_file 'Procfile'

        invoke_command 'add', 'sidekiq'

        expect_file_contents 'Gemfile', "gem 'sidekiq'"
        expect_dir_exists 'app/workers'
        expect_file_contents 'Procfile', 'bundle exec sidekiq'
      end
    end
  end

  describe 'update' do
    it 'runs `bundle update launch_base`' do
      expect_any_instance_of(LaunchBase::CLI).to receive(:system).with('bundle update launch_base --conservative')

      invoke_command 'update'
    end
  end

  describe 'lint install' do
    ['.codeclimate.yml', '.eslintrc.json', '.mdlrc', '.rubocop.yml', 'config.reek'].each do |configuration_file_name|
      it "installs the #{configuration_file_name} configuration file" do
        within_temp_test_directory do
          invoke_command 'lint', 'install'
        end

        source_file_path = templates_directory.join(configuration_file_name)
        destination_path = temp_test_directory.join(configuration_file_name)

        expect(destination_path.read).to eq source_file_path.read
      end
    end
  end

  describe 'lint update' do
    it 'updates the gem and installs the linter configuration files' do
      expect_any_instance_of(LaunchBase::CLI).to receive(:system).with('bundle update launch_base --conservative')

      within_temp_test_directory do
        invoke_command 'lint', 'update'
      end

      source_file_path = templates_directory.join('.codeclimate.yml')
      destination_path = temp_test_directory.join('.codeclimate.yml')

      expect(destination_path.read).to eq source_file_path.read
    end
  end

  describe 'help' do
    it 'includes the banner' do
      output = invoke_command 'help'

      expect(output).to match(/Kabisa LaunchBase/i)
    end
  end

  def stub_installed_rails_version(version = "Rails 5.2.0\n")
    expect(LaunchBase::Utilities).to receive(:`).with(/rails -v/).and_return(version)
  end
end
