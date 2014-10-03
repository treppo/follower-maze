module FollowerMaze
  class MessageDispatch
    def initialize(source:, recipients:)
      @source = source
      @recipients = recipients
    end

    def start
      while line = @source.next
        @recipients.each { |id, c| c.send line }
      end
    end
  end
end
