describe LaunchBase::CLI do
  describe 'update' do
    it 'runs `bundle update launch_base`' do
      expect_any_instance_of(LaunchBase::CLI).to receive(:system).with('bundle update launch_base')

      LaunchBase::CLI.start ['update']
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
