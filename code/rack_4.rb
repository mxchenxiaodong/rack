

require 'rack'

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


rack_app = lambda{ |env|
  request = Rack::Request.new(env)
  response = Rack::Response.new
  body = ""
  if request.path_info == "/hello" # 路由

    body << " you say hello <br>"
    body << "from #{client} <br>" if client = request['client']

  else
    body << "you need enter something.<br>"
  end


  # response.body = [body]
  # response.header['Content-Length'] = body.bytesize.to_s
  # response.finish

  response.write body
  # response.header['Content-Type'] = 'text/plain'
  response.header['Content-Type'] = 'text/html'
  response.finish
}

Rack::Handler::WEBrick.run Decorator.new(rack_app), :Port => 3000