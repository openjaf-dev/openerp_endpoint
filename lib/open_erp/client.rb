module OpenErp
  class Client
    attr_reader :client

    def initialize(url, database, username, password)
      @client = Ooor.new url: url,           database: database,
                         username: username, password: password
    end


    def send_order(payload, config)
      OpenErp::OrderBuilder.new(payload, config).build!
    end

    def send_updated_order(payload, config)
      OpenErp::OrderBuilder.new(payload, config).update!
    end

    def update_stock(payload)
      OpenErp::StockMonitor.run!(payload)
    end

    def confirm_shipment
      OpenErp::ShippingMonitor.run!
    end

    def import_products
      OpenErp::ProductImporter.run!
    end
  end
end
