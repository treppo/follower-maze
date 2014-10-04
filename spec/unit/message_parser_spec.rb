require 'minitest/autorun'
require 'message_parser'

module FollowerMaze
  describe MessageParser do
    before do
      @sut = MessageParser
    end

    it 'parses broadcast messages' do
      raw_message = "542532|B\r\n"

      message = @sut.parse raw_message

      message.must_equal(BroadcastMessage.new(542532, 0, 0, raw_message))
    end

    it 'parses private messages' do
      raw_message = "43|P|32|56\r\n"

      message = @sut.parse raw_message

      message.must_equal(PrivateMessage.new(43, 32, 56, raw_message))
    end
  end
end
