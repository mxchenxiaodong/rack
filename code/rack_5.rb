require 'rack'

# 一个装饰器。
class Decorator
  def initialize(app, *option, &block)
    @app = app
    @option = option[0] || {}
  end

  def call(env)
    status, headers, body = @app.call(env)
    new_body = (@option[:header] || "-- header --")

    body.each {|str| new_body << str}

    # p body.inspect # 打印出来。

    new_body << (@option[:footer] || "-- footer --")
    new_body << "<b>here is bye bye ... </b>"

    headers['Content-Length'] = new_body.bytesize.to_s  # 重新计算头部长度。
    [status, headers,[new_body]]
  end
end


# 一个DSL.
class Builder
  def initialize(&block)
    @middlewares = []

    # self为new对象、这句话会自动执行block。可以这么理解，把block加在这里执行。
    self.instance_eval(&block)
  end

  def use(middleware_class, *option, &block)
    # 对于以后执行的代码，ruby给出的最好答案是lambda。
    @middlewares << lambda {|app| middleware_class.new(app, *option, &block)}
  end

  def run(app)
    # 保存最初的rack程序。
    @app = app
  end

  def to_app
    # 这个话很高明也很有意思。
    # 反转 + 一层一层包装原先的rack程序。
    @middlewares.reverse.inject(@app) {|app, middleware| middleware.call(app)}
  end
end

# 实现一个简单的DSL
# 一个简单的Rack程序可以加工一下，返回指定的内容，变成另一个Rack程序。
rack_app = Builder.new {

  use Rack::ContentLength                                                         # 一个中间件
  use Decorator, :header => "-- header -- ", :footer => "-- footer --"            # 一个中间件
  run app lambda {|env| [200, {"Content-Type" => "text/html"}, ["hello word."]]}  # 最简单的Rack程序

}.to_app


Rack::Handler::WEBrick.run rack_app, :Port => 3000  # 启动服务，浏览器可以访问。




