describe LaunchBase::CLI do
  describe 'update' do
    it 'runs `bundle update launch_base`' do
      expect_any_instance_of(LaunchBase::CLI).to receive(:system).with('bundle update launch_base')

      LaunchBase::CLI.start ['update']
    end
  end

  describe 'lint install' do
    ['.codeclimate.yml', '.eslintrc.json', '.mdlrc', '.rubocop.yml', 'config.reek'].each do |configuration_file_name|
      it "installs the #{configuration_file_name} configuration file" do
        test_directory = Pathname.new('tmp').join('launch_base', 'test_space')
        FileUtils.rm_rf(test_directory)
        FileUtils.mkdir_p(test_directory)

        FileUtils.cd(test_directory) do
          LaunchBase::CLI.start ['lint', 'install']
        end

        templates_directory = Pathname.new(__dir__).join('..', '..', 'templates')
        source_file_path = templates_directory.join(configuration_file_name)
        destination_path = test_directory.join(configuration_file_name)

        expect(destination_path.read).to eq source_file_path.read
      end
    end
  end

  describe 'help' do
    it 'includes the banner' do
      output = capture :stdout do
        LaunchBase::CLI.start ['help']
      end

      expected = /Kabisa LaunchBase/i
      expect(output).to match expected
    end
  end
end
