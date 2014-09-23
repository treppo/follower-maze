require 'minitest/autorun'
require_relative 'client'
require_relative 'event_source'
require 'follower_maze'

describe FollowerMaze do
  describe 'Broadcasting a message' do
    it 'sends the payload to connected clients' do
      event_source = EventSource.new
      client = Client.new

      event_source.connect
      client.connect
      event_source.broadcast

      client.assert_broadcast_reception

      event_source.disconnect
      client.disconnect
    end
  end
end
