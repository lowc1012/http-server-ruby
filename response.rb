class Response
  def initialize(code:, body: '', headers: {})
    @code = code
    @body = body
    @headers = headers
  end

  def send(client)
    client.print "HTTP/1.1 #{@code}\r\n"
    @headers.each do |k, v|
      client.print "#{k}: #{v}\r\n"
    end
    client.print "\r\n"
    client.print @body unless @body.empty?

    puts "-> #{@code}"
  end
end
