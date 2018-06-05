lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'launch_base/version'

Gem::Specification.new do |spec|
  spec.name          = 'launch_base'
  spec.version       = LaunchBase::VERSION
  spec.authors       = ['Martijn Versluis', 'Tjaco Oostdijk']
  spec.email         = ['martijn@kabisa.nl', 'tjaco@kabisa.nl']

  spec.summary       = 'A Rails template with Kabisa defaults'
  spec.homepage      = 'https://github.com/kabisa/launch-base'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    is_test_file = f.match(%r{^(test|spec|features)/})
    is_symlink = File.symlink?(f)
    is_file_to_ignore = [
      '.gitignore',
      '.codeclimate.yml',
      '.rspec',
      '.rspec-status',
      '.travis.yml',
      '.ruby-version',
      'package.json',
      'Rakefile',
      'yarn.lock'
    ].include? f

    is_test_file || is_symlink || is_file_to_ignore
  end

  spec.bindir = 'bin'
  spec.executables   = ['launch_base']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'fuubar', '~> 2.3'
  spec.add_development_dependency 'rubocop', '~> 0.55'
  spec.add_development_dependency 'reek', '~> 4.8'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'redcarpet', '~> 3.4'

  spec.add_dependency 'thor', '~> 0.20'

  spec.add_development_dependency 'gem-release', '~> 1.0'
end
