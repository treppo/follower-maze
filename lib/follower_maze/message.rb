require_relative 'message_parser'

module FollowerMaze
  class Message
    def initialize(raw, message_parser = MessageParser)
      @raw = raw
      @message_parser = message_parser
    end

    def send_to(recipients)
      parsed_message.send_to(recipients)
    end

    private

    attr_reader :raw, :message_parser

    def parsed_message
      message_parser.parse(raw)
    end
  end
end
