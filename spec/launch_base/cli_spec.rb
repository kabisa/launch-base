describe LaunchBase::CLI do
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

      expected = /Kabisa LaunchBase/i
      expect(output).to match expected
    end
  end
end
