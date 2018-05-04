# From https://github.com/erikhuda/thor/blob/master/spec/helper.rb
def capture(stream)
  begin
    stream = stream.to_s

    create_stream(stream)
    yield
    result = read_stream(stream)
  ensure
    stream_to_upcase(stream)
  end

  result
end

def create_stream(stream)
  eval <<-RUBY, binding, __FILE__, __LINE__ + 1
    $#{stream} = StringIO.new
  RUBY
end

def read_stream(stream)
  result = eval <<-RUBY, binding, __FILE__, __LINE__ + 1
    $#{stream}
  RUBY
  result.string
end

def stream_to_upcase(stream)
  eval <<-RUBY, binding, __FILE__, __LINE__ + 1
    $#{stream} = #{stream.upcase}
  RUBY
end
