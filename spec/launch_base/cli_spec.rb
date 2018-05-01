describe LaunchBase::CLI do
  describe 'update' do
    it 'runs `bundle update launch_base`' do
      expect_any_instance_of(LaunchBase::CLI).to receive(:system).with('bundle update launch_base')

      LaunchBase::CLI.new.invoke :update
    end
  end
end
