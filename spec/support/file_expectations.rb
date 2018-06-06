require 'rspec/matchers'

module FileExpectations
  include RSpec::Matchers

  def expect_file_contents(file_path, expected_contents)
    file_contents = File.read(resolve_file_path(file_path))

    case expected_contents
    when Regexp
      expect(file_contents).to match(expected_contents)
    else
      expect(file_contents).to include(expected_contents)
    end
  end

  def expect_dir_exists(directory_path)
    expect(directory_existence(directory_path)).to be true
  end

  def expect_dir_exists_not(directory_path)
    expect(directory_existence(directory_path)).to be false
  end

  def expect_file_exists(file_path)
    expect(file_existence(file_path)).to be true
  end

  protected

  def directory_existence(directory_path)
    File.directory?(resolve_file_path(directory_path))
  end

  def file_existence(file_path)
    File.exist?(resolve_file_path(file_path))
  end
end
