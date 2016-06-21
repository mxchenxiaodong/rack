

require 'rack'

rack_app = lambda { |env|

  request = Rack::Request.new(env)
  response = Rack::Response.new

  body = "---------header----------<br>"
  if request.path_info == "/hello" # 路由

    body << " you say hello <br>"
    body << "from #{client} <br>" if client = request['client']

  else
    body << "you need enter something.<br>"
  end

  body << "---------footer----------<br>"
  body << "<b>here is bye bye ... </b>"

  # response.body = [body]
  # response.header['Content-Length'] = body.bytesize.to_s
  # response.finish

  response.write body
  # response.header['Content-Type'] = 'text/plain'
  response.header['Content-Type'] = 'text/html'
  response.finish
}

Rack::Handler::WEBrick.run rack_app, :Port => 3000