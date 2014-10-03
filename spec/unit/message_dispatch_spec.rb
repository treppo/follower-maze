require 'minitest/autorun'
require 'message_dispatch'

module FollowerMaze
  describe MessageDispatch do
    before do
      @source = Class.new do
        def next
          return nil if @done
          @done = true
          return 'broadcast message'
        end
      end.new
      @recipient1 = Minitest::Mock.new
      @recipient2 = Minitest::Mock.new
      recipients = { :'1' => @recipient1, :'2' => @recipient2 }
      @sut = MessageDispatch.new(source: @source, recipients: recipients)
    end

    it 'sends broadcasts to all recipients' do
      @recipient1.expect :send, nil, ['broadcast message']
      @recipient2.expect :send, nil, ['broadcast message']

      @sut.start

      @recipient1.verify
      @recipient2.verify
    end
  end
end
