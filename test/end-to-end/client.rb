require 'socket'
require 'minitest/assertions'

class Client
  include Minitest::Assertions

  def connect
    @socket = TCPSocket.new 'localhost', 9099
  end

  def assert_broadcast_reception
    payload = @socket.gets
    @socket.close

    assert_equal 'broadcast payload', payload
  end
end
