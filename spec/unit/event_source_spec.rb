require 'minitest/autorun'
require 'event_source'

module FollowerMaze
  describe EventSource do
    it 'connects to source and receives messages' do
      @sut = EventSource.new
      @source = TCPSocket.new('localhost', 9090)

      @sut.connect
      @source.puts 'message\r\n'

      @sut.next.must_equal 'message\r\n'
    end
  end
end
