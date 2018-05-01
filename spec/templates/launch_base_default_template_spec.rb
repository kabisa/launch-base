require 'spec_helper'

RSpec.describe "App Generator" do

  before(:all) do
    generate_new_app
  end

  after(:all) do
    remove_generated_app
  end

  it 'creates the root folder for the new application' do
    expect(File).to exist("#{project_path}/Gemfile")
  end

  it 'uses custom Gemfile' do
    gemfile_file = File.read("#{project_path}/Gemfile")

    expect(gemfile_file)
      .to match(/gem 'rails', '#{LaunchBase::RAILS_VERSION}'/)
  end

  it 'sets the correct ruby version in the .ruby-version file' do
    ruby_version_file = File.read("#{project_path}/.ruby-version")

    expect(ruby_version_file)
      .to match(/^#{LaunchBase::RUBY_VERSION}$/)
  end
end
