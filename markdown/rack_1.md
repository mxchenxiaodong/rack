
1、[rack的规范](http://www.rubydoc.info/github/rack/rack/master/file/SPEC)    

2、[github地址](https://github.com/rack/rack)


```

# require 'rubygems'
require 'rack'

def p_rack_env(env)
  env.map{ |key, value| "#{key} - #{value}" }.sort.join("\n")
end

Rack::Handler::WEBrick.run lambda {|env| [200, {}, [p_rack_env(env)]]}, :Port => 3000


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

```

Request
有两大类：一类是CGI.一类是rack要求的。
request = Rack::Request.new(env)
request.path_info == '/guess'

Response
浏览器从Content-Length头信息决定从服务端读取多少数据。

两种方法：
- 一种直接设置response.body, 并手动设置Content-Length的值。
- 一种是用response.write来写body,会自动计算Content-Length的值。 



Content 是这个资源的实际大小，Size 则是传输时的大小。
Content-Length的单位是什么？-- -- 字节

Content-Type -- -- 'text/html'  html
                   'text/plain' 文本

response.finish会自动封装成rack对象 -- -- 即[code, header, body]



[状态码，响应头，body]
状态码：不一定是整数，可以to_i.必须大于100
响应头：必须可以each。key-value. key必须是字符串，不能是符号。整体hash符合。
body

# 中间件（使用装饰器模式）
中间件可以实现通用逻辑与业务逻辑的分离。业务逻辑可以各不同。
中间件本身也是合法的rack程序。每个中间件只需关注自身需要实现的功能。
- 每个中间件都可以独立发展，甚至可以被替换。
- 可以不同地组合中间件，满足不同的程序需要。



注意递归。