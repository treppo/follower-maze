require 'socket'

module Test
  class EventSource
    def connect
      @socket = TCPSocket.new 'localhost', 9090
    end

    def broadcast
      @socket.write '542532|B\r\n'
    end

    def send_pm(id)
      @socket.write "43|P|32|#{id}\r\n"
    end

    def disconnect
      @socket.close
    end
  end
end
