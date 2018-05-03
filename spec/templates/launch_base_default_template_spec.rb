describe 'App Generator' do
  it 'uses custom Gemfile' do
    expect_file_contents 'Gemfile', /gem 'rails', '5.2.0'/
  end

  it 'sets the correct ruby version in the .ruby-version file' do
    expect_file_contents '.ruby-version', /^#{LaunchBase::RUBY_VERSION}$/
  end

  it 'generates a database.yml configured for PostgreSQL usage' do
    expect_file_contents 'config/database.yml', /adapter: postgresql/
  end

  it 'generates a .rspec file' do
    expect_file_contents '.rspec', /--format Fuubar/
  end

  ['factories', 'features', 'fixtures', 'models', 'requests', 'support'].each do |spec_sub_directory_name|
    it "generates a spec/#{spec_sub_directory_name} directory" do
      expect_dir_exists("spec/#{spec_sub_directory_name}")
    end
  end

  it 'removes the test/ directory' do
    expect_dir_exists_not 'test'
  end

  it 'adds a ping spec' do
    expect_file_contents 'spec/requests/ping_spec.rb', "describe '/ping'"
  end

  it 'adds a /ping route' do
    expect_file_contents 'config/routes.rb', "get '/ping'"
  end

  it 'migrates the database' do
    expect_file_exists 'db/schema.rb'
  end
end
