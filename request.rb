class Request
  attr_reader :method, :path, :body, :headers

  def initialize(request)
    lines = request.lines
    index = lines.index("\r\n")

    @method, @path = lines.first.split
    @path, @query = @path.split('?')
    @headers = parse_headers(lines[1...index])
    @body = lines[(index + 1)..-1].join
  end

  def parse_headers(lines)
    headers = {}
    lines.each do |line|
      k, v = line.split(': ')
      headers[k] = v.chomp.to_i # Returns a new String with the given record separator removed from the end of str
    end

    headers
  end

  def content_length
    headers['Content-Length'].to_i
  end
end
