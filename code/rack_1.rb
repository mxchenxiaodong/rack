
# require 'rubygems'
require 'rack'

def p_rack_env(env)
  env.map{ |key, value| "#{key} - #{value}" }.sort.join("\n")
end

Rack::Handler::WEBrick.run lambda {|env| [200, {}, [p_rack_env(env)]]}, :Port => 3000

# return below
# GATEWAY_INTERFACE - CGI/1.1
# HTTP_ACCEPT - text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# HTTP_ACCEPT_ENCODING - gzip, deflate, sdch
# HTTP_ACCEPT_LANGUAGE - zh-CN,zh;q=0.8,en;q=0.6
# HTTP_CONNECTION - keep-alive
# HTTP_HOST - localhost:3000
# HTTP_UPGRADE_INSECURE_REQUESTS - 1
# HTTP_USER_AGENT - Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36
# HTTP_VERSION - HTTP/1.1
# PATH_INFO - /search
# QUERY_STRING - key=redis
# REMOTE_ADDR - ::1
# REMOTE_HOST - ::1
# REQUEST_METHOD - GET
# REQUEST_PATH - /search
# REQUEST_URI - http://localhost:3000/search?key=redis
# SCRIPT_NAME -
# SERVER_NAME - localhost
# SERVER_PORT - 3000
# SERVER_PROTOCOL - HTTP/1.1
# SERVER_SOFTWARE - WEBrick/1.3.1 (Ruby/2.3.0/2015-12-25)
# rack.errors - #<IO:0x007fb9b309eb28>
# rack.hijack - #<Proc:0x007fb9b247fae0@/Users/Don/.rvm/gems/ruby-2.3.0/gems/rack-1.6.4/lib/rack/handler/webrick.rb:76 (lambda)>
# rack.hijack? - true
# rack.hijack_io -
# rack.input - #<StringIO:0x007fb9b247fc20>
# rack.multiprocess - false
# rack.multithread - true
# rack.run_once - false
# rack.url_scheme - http
# rack.version - [1, 3]