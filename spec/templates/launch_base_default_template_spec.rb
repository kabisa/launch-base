describe 'App Generator', :needs_dummy_app do
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

  it 'creates a README.md file' do
    readme_file = File.read("#{project_path}/README.md")

    expected = /Rails app generated by Kabisa LaunchBase/i
    expect(readme_file).to match expected
  end

  it 'adds a homepage controller' do
    expect_file_contents 'app/controllers/homepage_controller.rb', 'class HomepageController'
  end

  it 'adds a homepage view' do
    expect_file_contents 'app/views/homepage/show.html.erb', 'Rails app generated by Kabisa LaunchBase'
  end

  it 'adds a homepage route' do
    expect_file_contents 'config/routes.rb', "root to: 'homepage#show'"
  end

  it 'adds capybara configuration' do
    expect_file_contents 'spec/support/capybara.rb', 'Capybara.register_driver :selenium_chrome_headless'
  end

  it 'adds FactoryBot configuration' do
    expect_file_contents 'spec/support/factory_bot.rb', 'config.include FactoryBot::Syntax::Methods'
  end

  it 'adds a module for feature spec helpers' do
    expect_file_contents 'spec/support/feature_spec_helpers.rb', 'module FeatureSpecHelpers'
  end

  it 'adds a module for general spec helpers' do
    expect_file_contents 'spec/support/spec_helpers.rb', 'module SpecHelpers'
  end

  it 'adds a custom rails_helper file' do
    expect_file_contents 'spec/rails_helper.rb', 'config.include FeatureSpecHelpers, type: :feature'
  end

  it 'adds a Code Climate configuration file' do
    expect_file_exists '.codeclimate.yml'
  end

  it 'adds a ESLint configuration file' do
    expect_file_exists '.eslintrc.json'
  end

  it 'adds a Markdownlint configuration file' do
    expect_file_exists '.mdlrc'
  end

  it 'adds a Rubocop configuration file' do
    expect_file_exists '.rubocop.yml'
  end

  it 'adds a Reek configuration file' do
    expect_file_exists 'config.reek'
  end

  it 'activates raising on missing translations for development environment' do
    expect_file_contents(
      'config/environments/development.rb',
      '  config.action_view.raise_on_missing_translations = true'
    )
  end

  it 'activates raising on missing translations for test environment' do
    expect_file_contents 'config/environments/test.rb', '  config.action_view.raise_on_missing_translations = true'
  end

  it 'activates raising application errors for test environment' do
    expect_file_contents 'config/environments/test.rb', '  config.action_dispatch.show_exceptions = false'
  end

  it 'adds a ci Dockerfile' do
    expect_file_exists 'dockerfiles/ci/Dockerfile'
  end

  it 'adds a bin/ci file' do
    expect_file_exists 'bin/ci'
  end

  it 'adds an prefilled app.json file' do
    expect_file_contents 'app.json', '"name": "dummy-app"'
    expect_file_contents 'app.json', '"description": "Dummy app"'
  end

  it 'adds a post_deploy file' do
    expect_file_exists 'bin/post_deploy'
  end

  it 'adds a prefilled Jenkinsfile' do
    [
      'projectId = "dummy-app"',
      "CODECLIMATE_REPO_TOKEN = credentials('dummy-app_codeclimate_test_reporter_id')",
      "sh 'ssh-keyscan -H dummy-app.staging.kabisa.nl >>",
      'git remote add dokku-staging dokku@dummy-app.staging.kabisa.nl:dummy-app-staging',
      /support\.slackNotification\(channel: "#dummy-app"\)/,
      'ssh-keyscan -H dummy-app.production.kabisa.nl',
      /git remote add dokku-production dokku@dummy-app.production.kabisa.nl:dummy-app-production/,
      /support\.slackNotification\(channel: "#dummy-app"\)/
    ].each do |expected_content|
      expect_file_contents 'Jenkinsfile', expected_content
    end
  end

  it 'sets the production log level to info' do
    expect_file_contents 'config/environments/production.rb', 'config.log_level = :info'
  end
end
