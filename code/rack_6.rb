

require 'rack'

# 一个web程序用不同的代码来处理不同的url，这就是所谓的路由系统。
# 最简单的路由系统就是一个URL 对应 一个代码块。
# run 方法是Rack::Builder已经定义的。用来存最原始的app rack程序.
app = Rack::Builder.new {
  map '/hello' do
    run lambda {|env| [200, {}, ["hello"]]}
  end

  map '/bye' do
    run lambda {|env| [200, {}, ["bye"]]}
  end

  map '/haha' do
    run lambda {|env| [200, {}, ["haha"]]}
  end
}

Rack::Handler::WEBrick.run app, :Port => 3000