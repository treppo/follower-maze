module FollowerMaze
  class MessageDispatch
    def initialize(source:, recipients:, message_class:)
      @source = source
      @recipients = recipients
      @message_class = message_class
    end

    def start
      while line = @source.next
        @message_class.new(line).send_to(@recipients)
      end
    end
  end
end
