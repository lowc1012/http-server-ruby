require 'socket'
require_relative './request'
require_relative './response'

puts 'Starting TCP server listening on port 3001'
server = TCPServer.new('localhost', 3001)

def render(path)
  _path = File.join(__dir__, 'views', path)
  if File.exist?(_path)
    Response.new(code: 200, body: File.binread(_path))
  else
    Response.new(code: 404)
  end
end

def route(request)
  if request.path == '/'
    render('index.html')
  else
    render(request.path)
  end
end

# Wait for a client to connect
# create a thread to respond each http request
loop do
  Thread.start(server.accept) do |client|
    req = Request.new(client.readpartial(2048))
    res = route(req)
    res.send(client)
    client.close
  end
end
