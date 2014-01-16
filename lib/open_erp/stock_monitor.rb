module OpenErp
  class StockMonitor
    class << self
      def run!(payload)
        product_id = ProductProduct.find(:all, fields: ['code']).find { |p| p.code == payload['sku'] }.try(:id)

        raise OpenErpEndpointError, "Product #{payload['sku']} could not be found on OpenERP!" unless product_id

        product = ProductProduct.find(product_id)

        return {
          'sku' => payload['sku'],
          'quantity' => product.qty_available.to_i
        }
      end
    end
  end
end
