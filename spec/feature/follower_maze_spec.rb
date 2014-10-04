require 'minitest/autorun'
require_relative 'fake_client'
require_relative 'fake_event_source'
require 'follower_maze'

Thread.abort_on_exception = true

class FollowerMazeSpec < Minitest::Spec
  def self.before_all
    @@event_source = FakeEventSource.new
    @@client1 = FakeClient.new(id: 1)
    @@client2 = FakeClient.new(id: 2)
    @@app = FollowerMaze::Main.new

    Thread.new { @@app.start }

    @@event_source.connect
    @@client1.connect
    @@client2.connect
  end

  before_all

  describe FollowerMaze do
    describe 'Broadcasting a message' do
      it 'sends the payload to connected clients' do
        @@event_source.broadcast

        @@client1.assert_broadcast_reception
        @@client2.assert_broadcast_reception
      end
    end

    describe 'Send a private message' do
      it 'sends the payload to the right client' do
        @@event_source.send_pm(recipient: 1)
        @@event_source.send_pm(recipient: 2)

        @@client1.assert_pm_reception
        @@client2.assert_pm_reception
      end
    end
  end
end
