require 'socket'

class EventSource
  def initialize
    @server = TCPServer.new(9090)
  end

  def connect
    @socket = @server.accept
  end

  def next
    @socket.gets("\r\n")
  end
end
