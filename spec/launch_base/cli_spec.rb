describe LaunchBase::CLI do
  describe 'update' do
    it 'runs `bundle update launch_base`' do
      expect_any_instance_of(LaunchBase::CLI).to receive(:system).with('bundle update launch_base')

      LaunchBase::CLI.new.invoke :update
    end
  end

  describe 'help' do
    it 'includes the banner' do
      cli = LaunchBase::CLI.new

      output = capture :stdout do
        cli.invoke :help
      end

      expect(output).to match /Kabisa LaunchBase/i
    end
  end
end
