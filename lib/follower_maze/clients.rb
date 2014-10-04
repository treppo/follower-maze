class Clients
  def initialize
    @store = {}
  end

  def send(to, payload)
    @store[to].send(payload)
  end

  def send_to_all(payload)
    @store.each { |_, client| client.send(payload) }
  end

  def []=(id, client)
    @store[id] = client
  end
end
