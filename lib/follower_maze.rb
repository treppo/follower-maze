require_relative 'follower_maze/message_dispatch'
require_relative 'follower_maze/message'
require_relative 'follower_maze/event_source'
require_relative 'follower_maze/client'
require_relative 'follower_maze/clients'

module FollowerMaze
  class Main
    def initialize
      @clients = Clients.new
      @event_source = EventSource.new
      @threads = []
    end

    def start
      @event_source.connect
      @threads << Thread.new { dispatch_messages }
      @threads << Thread.new { connect_clients }
    end

    def stop
      @threads.each { |t| t.exit }
    end

    private

    def connect_clients
      server = TCPServer.new(9099)

      loop do
        client = Client.connect(server)
        @clients[client.id] = client
      end
    end

    def dispatch_messages
      MessageDispatch.new(source: @event_source,
        message_class: Message,
        recipients: @clients).start
    end

  end
end
