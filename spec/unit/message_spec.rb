require 'message'

module FollowerMaze
  describe 'Message' do
    before do
      @message_parser = Minitest::Mock.new
      @parsed_message = Minitest::Mock.new
      @recipients = Class.new
      @message = Message.new('', @message_parser)
    end

    it 'sends message to recipients' do
      @message_parser.expect :parse, @parsed_message, ['']
      @parsed_message.expect :send_to, nil, [@recipients]

      @message.send_to(@recipients)

      @message_parser.verify
      @parsed_message.verify
    end
  end
end
