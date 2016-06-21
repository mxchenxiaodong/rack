require 'rack'
require 'pry'

class Decorator
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    new_body = "---------header----------<br>"

    body.each {|str| new_body << str}

    p body.inspect

    new_body << "---------footer----------<br>"
    new_body << "<b>here is bye bye ... </b>"

    headers['Content-Length'] = new_body.bytesize.to_s
    [status, headers,[new_body]]
  end
end

class Builder
  def intialize(&block)
    @middlewares = []
    self.instance_eval(&block)
  end

  def use(middleware_class, *option, &block)
    @middlewares << middleware_class.new()
  end

  def run

  end
end

# DSL
#
binding.pry
builder = Builder.new {
  use Rack::ContentLength # 一个中间件
  use Decorator # 一个中间件
}




