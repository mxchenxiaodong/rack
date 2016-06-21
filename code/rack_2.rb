
require 'rack'

# use lambda, beacause lambda can be call...
rack_app = lambda {|env|

  request = Rack::Request.new(env) # 使用Rack的类来进行初始化参数。
  if request.path_info == '/guess'
    client = request["client"] # url?client=xxx
    if client && client.downcase == 'safari'
      [200, {}, ["yeah, sweet heart!!"]]
    else
      [200, {}, ["please choose another one!!"]]
    end
  else
    [200, {}, ["you should choose /guess path!!"]]
  end

}

Rack::Handler::WEBrick.run rack_app, :Port => 3000