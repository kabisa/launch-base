# From https://github.com/erikhuda/thor/blob/master/spec/helper.rb
def capture(stream)
  begin
    stream = stream.to_s

    stub_stream(stream)
    yield
    result = read_stubbed_stream(stream)
  ensure
    unstub_stream(stream)
  end

  result
end

def stub_stream(stream)
  eval <<-RUBY, binding, __FILE__, __LINE__ + 1
    $#{stream} = StringIO.new
  RUBY
end

def read_stubbed_stream(stream)
  result = eval <<-RUBY, binding, __FILE__, __LINE__ + 1
    $#{stream}
  RUBY
  result.string
end

def unstub_stream(stream)
  eval <<-RUBY, binding, __FILE__, __LINE__ + 1
    $#{stream} = #{stream.upcase}
  RUBY
end
