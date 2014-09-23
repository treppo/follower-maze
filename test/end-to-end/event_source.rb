require 'socket'

class EventSource
  def connect
    @socket = TCPSocket.new 'localhost', 9090
  end

  def broadcast
    @socket.puts 'broadcast payload'
  end

  def disconnect
    @socket.close
  end
end
