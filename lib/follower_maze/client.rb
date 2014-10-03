require 'socket'

class Client
  attr_reader :id

  def self.connect(server)
    client = new(server)
    client.connect
    client
  end

  def initialize(server)
    @server = server
  end

  def connect
    @socket = @server.accept
    @id = @socket.gets
  end

  def send(message)
    @socket.puts(message)
  end
end
