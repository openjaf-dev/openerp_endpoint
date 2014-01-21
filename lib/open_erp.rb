require_relative './open_erp/client'
require_relative './open_erp/order_builder'
require_relative './open_erp/customer_manager'
require_relative './open_erp/stock_monitor'
require_relative './open_erp/shipping_monitor'
require_relative './open_erp/product_importer'

module OpenErp; end

class OpenErpEndpointError < StandardError; end
