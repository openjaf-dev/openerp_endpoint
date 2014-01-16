require 'ooor'
require 'pry'

module OpenErp
  class Client
    attr_reader :client

    def initialize(url, database, username, password)
      @client = Ooor.new url: url,           database: database,
                         username: username, password: password
    end


    def send_order(payload, config)
      result = OpenErp::OrderBuilder.new(payload, config).build!
    end

    def send_updated_order(payload, config)
      result = OpenErp::OrderBuilder.new(payload, config).update!
    end

    def update_stock(payload)
      result = OpenErp::StockMonitor.run!(payload)
    end
  end
end
