RSpec.describe LaunchBase do
  it 'has a version number' do
    expect(LaunchBase::VERSION).not_to be nil
  end

  it 'has a Rails version number' do
    expect(LaunchBase::RAILS_VERSION).not_to be nil
  end

  it 'has a Ruby Version defined' do
    expect(LaunchBase::RUBY_VERSION).not_to be nil
  end
end
