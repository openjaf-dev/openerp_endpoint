require_relative './lib/open_erp'

class OpenErpEndpoint < EndpointBase::Sinatra::Base
  set :logging, true

  before do
    @client = OpenErp::Client.new(@config['openerp.api_url'], @config['openerp.api_database'],
                                  @config['openerp.api_user'], @config['openerp.api_password'])
  end

  post '/order_export' do
    begin
      code = 200
      if @message[:message] == "order:new"
        response = @client.send_order(@message[:payload], @config)
      else
        response = @client.send_updated_order(@message[:payload], @config)
      end
      add_notification 'info', "Order sent to OpenERP",
        "The order #{@message[:payload]['order']['number']} was sent to OpenERP as #{response.name}."
    rescue => e
      code = 500
      error_notification(e)
    end

    process_result code
  end

  post '/monitor_stock' do
    begin
      code = 200
      response = @client.update_stock(@message[:payload])
      add_message 'stock:actual', response

      add_notification 'info', "Stock updated for product #{@message[:payload]['sku']}", "This products count on hand now reflects the inventory_qty from OpenERP."
    rescue => e
      code = 500
      error_notification(e)
    end
    process_result code
  end

  post '/confirm_shipment' do
    begin
      code = 200
      response = @client.confirm_shipment
      add_messages 'shipment:confirm', response

      add_notification 'info', 'Confirmed shipment', 'The shipment was confirmed'
    rescue => e
      raise "#{e.message} #{e.backtrace.inspect}"
      code = 500
      error_notification(e)
    end
    process_result code
  end

  def error_notification(error)
    add_notification 'error', 'An OpenERP Endpoint error has occured', "#{error.message}\n#{error.backtrace.join("\n")}"
  end
end
