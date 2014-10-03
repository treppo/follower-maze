require 'socket'
require 'minitest/assertions'

module Test
  class Client
    include Minitest::Assertions

    attr_accessor :assertions

    def initialize(id)
      @id = id
      @assertions = 0
    end

    def connect
      @socket = TCPSocket.new 'localhost', 9099
      @socket.puts "#{@id}\r\n"
    end

    def assert_broadcast_reception
      assert_equal '542532|B\r\n', next_event
    end

    def assert_pm_reception
      assert_equal "43|P|32|#{@id}\r\n", next_event
    end

    def disconnect
      @socket.close
    end

    private

    def next_event
      @socket.gets('\r\n')
    end
  end
end
