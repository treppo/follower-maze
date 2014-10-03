require 'minitest/autorun'
require_relative 'client'
require_relative 'event_source'
require 'follower_maze'

describe FollowerMaze do
  before do
    @event_source = Test::EventSource.new
    @client1 = Test::Client.new(1)
    @client2 = Test::Client.new(2)
    @app = FollowerMaze::Main.new

    Thread.new { @app.start }

    @event_source.connect
    @client1.connect
    @client2.connect
  end

  after do
    @event_source.disconnect
    @client1.disconnect
    @client2.disconnect
    @app.stop
  end

  describe 'Broadcasting a message' do
    it 'sends the payload to connected clients' do
      @event_source.broadcast

      @client1.assert_broadcast_reception
      @client2.assert_broadcast_reception
    end
  end

  describe 'Send private a message' do
    it 'sends the payload to the right client' do
      @event_source.send_pm(recipient: 1)
      @event_source.send_pm(recipient: 2)

      @client1.assert_pm_reception
      @client2.assert_pm_reception
    end
  end
end
