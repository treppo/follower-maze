require 'socket'

class FakeEventSource
  def connect
    @socket = TCPSocket.new 'localhost', 9090
  end

  def broadcast
    @socket.puts "542532|B\r\n"
  end

  def send_pm(recipient:)
    @socket.puts "43|P|32|#{recipient}\r\n"
  end

  def disconnect
    @socket.close
  end
end
