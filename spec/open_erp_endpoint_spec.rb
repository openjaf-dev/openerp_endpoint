require 'spec_helper'

describe OpenErpEndpoint do
  def app
    OpenErpEndpoint
  end

  def auth
    {'HTTP_X_AUGURY_TOKEN' => '6a204bd89f3c8348afd5c77c717a097a', "CONTENT_TYPE" => "application/json"}
  end

  let(:order) { Factories.order }
  let(:original) { Factories.original }
  let(:params) { Factories.parameters }

  describe '/order_export' do
    context 'new order' do
      context 'success' do
        it 'sends the order to OpenERP' do
          message = {
            message_id: '123456',
            message: 'order:new',
            payload: {
              order: order,
              original: original,
              parameters: params
            }
          }.to_json

          VCR.use_cassette('order_export_success') do
            post '/order_export', message, auth
            last_response.status.should == 200
            last_response.body.should match /was sent to OpenERP/
          end
        end
      end
    end

    context 'updated order' do
      context 'success' do
        it 'sends the order to OpenERP' do
          message = {
            message_id: 123456,
            message: 'order:updated',
            payload: {
              order: order,
              original: original,
              parameters: params
            }
          }.to_json

          VCR.use_cassette('order_export_update_success') do
            post '/order_export', message, auth
            last_response.status.should == 200
            last_response.body.should match /was sent to OpenERP/
          end
        end
      end
    end
  end

  describe '/monitor_stock' do
    context 'success' do
      it 'generates a stock actual message for a changed product' do
        message = {
          message_id: 123456,
          message: 'stock:query',
          payload: {
            sku: 'ROR-00011',
            parameters: params
          }
        }.to_json

        VCR.use_cassette('monitor_stock_success') do
          post '/monitor_stock', message, auth
          last_response.status.should == 200
        end
      end
    end

    context 'failure' do
      it 'returns an error notification if the product does not exist on OpenERP' do
        message = {
          message_id: 123456,
          message: 'stock:query',
          payload: {
            sku: 'ROR-99999',
            parameters: params
          }
        }.to_json

        VCR.use_cassette('monitor_stock_no_product') do
          post '/monitor_stock', message, auth
          last_response.status.should == 500
          last_response.body.should match /OpenERP Endpoint error/
        end
      end
    end
  end

  describe '/confirm_shipment' do
    context 'success' do
      it 'generates a shipment confirm message for a shipped order' do
        message = {
          message_id: 123456,
          message: 'openerp:shipment:confirm',
          payload: {
            parameters: params
          }
        }.to_json

        VCR.use_cassette('confirm_shipment_success') do
          post '/confirm_shipment', message, auth
          last_response.status.should == 200
          last_response.body.should match /Confirmed shipment/
          last_response.body.should match /shipment:confirm/
          last_response.body.should match /inflate/
        end
      end
    end
  end

  describe '/import_products' do
    context 'success' do
      it 'generates a product:import for an imported product' do
        message = {
          message_id: 123456,
          message: 'openerp:product:import',
          payload: {
            parameters: params
          }
        }.to_json

        VCR.use_cassette('import_product_success') do
          post '/import_products', message, auth
          last_response.status.should == 200
          last_response.body.should match /Imported products/
          last_response.body.should match /product:import/
        end
      end
    end
  end
end
