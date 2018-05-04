# From https://github.com/erikhuda/thor/blob/master/spec/helper.rb
def capture(stream)
  begin
    stream = stream.to_s
    eval <<-RUBY, binding, __FILE__, __LINE__ + 1
      $#{stream} = StringIO.new
    RUBY
    yield
    result = eval <<-RUBY, binding, __FILE__, __LINE__ + 1
      $#{stream}
    RUBY
    result = result.string
  ensure
    eval <<-RUBY, binding, __FILE__, __LINE__ + 1
      $#{stream} = #{stream.upcase}
    RUBY
  end

  result
end
