BroadcastMessage = Struct.new(:id, :from, :to, :payload) do
  def send_to(recipients)
    recipients.send_to_all(payload)
  end
end

PrivateMessage = Struct.new(:id, :from, :to, :payload) do
  def send_to(recipients)
    recipients.send(to, payload)
  end
end

module FollowerMaze
  class MessageParser
    class << self
      def parse(raw)
        fields = raw.chomp.split '|'

        message_class(fields[1]).new(fields[0].to_i,
          fields[2].to_i,
          fields[3].to_i,
          raw)
      end

      private

      def message_class(raw_type)
        Object.const_get("#{message_type(raw_type).capitalize}Message")
      end

      def message_type(raw_type)
        { 'B' =>  :broadcast,
          'P' => :private }.fetch(raw_type)
      end
    end
  end
end
