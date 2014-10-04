require 'minitest/autorun'
require 'message_dispatch'

module FollowerMaze
  describe MessageDispatch do
    before do
      @message_class = Minitest::Mock.new
      @message = Minitest::Mock.new
      @recipients = Class.new
    end

    it 'sends broadcasts to all recipients' do
      @sut = MessageDispatch.new(source: create_source('bm'),
                                 recipients: @recipients,
                                 message_class: @message_class)
      @message_class.expect :new, @message, ['bm']
      @message.expect :send_to, nil, [@recipients]

      @sut.start

      @message_class.verify
      @message.verify
    end

    it 'sends private messages to the right recipients' do
      @sut = MessageDispatch.new(source: create_source('pm'),
                                 recipients: @recipients,
                                 message_class: @message_class)
      @message_class.expect :new, @message, ['pm']
      @message.expect :send_to, nil, [@recipients]

      @sut.start

      @message_class.verify
      @message.verify
    end

    def create_source(message)
      Class.new do
        def initialize(message)
          @message = message
        end

        def next
          return nil if @done
          @done = true
          return @message
        end
      end.new(message)
    end
  end
end
