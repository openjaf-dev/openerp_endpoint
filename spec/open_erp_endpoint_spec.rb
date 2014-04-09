require 'spec_helper'

describe OpenErpEndpoint do
  def app
    OpenErpEndpoint
  end

  let(:order) { Factories.order }
  let(:params) { Factories.parameters }

  describe '/order_export' do
    context 'new order' do
      context 'success' do
        it 'sends the order to OpenERP' do
          message = {
            order: order,
            parameters: params
          }.to_json

          VCR.use_cassette('order_export_success') do
            post '/add_order', message, auth
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
            order: order,
            parameters: params
          }.to_json

          VCR.use_cassette('order_export_update_success') do
            post '/update_order', message, auth
            last_response.status.should == 200
            last_response.body.should match /was sent to OpenERP/
          end
        end
      end
    end
  end

  describe '/get_inventory' do
    context 'success' do
      it 'generates a stock actual message for a changed product' do
        message = {
          sku: 'ROR-00011',
          parameters: params
        }.to_json

        VCR.use_cassette('monitor_stock_success') do
          post '/get_inventory', message, auth
          last_response.status.should == 200
        end
      end
    end

    context 'failure' do
      it 'returns an error notification if the product does not exist on OpenERP' do
        message = {
          sku: 'ROR-99999',
          parameters: params
        }.to_json

        VCR.use_cassette('monitor_stock_no_product') do
          post '/get_inventory', message, auth
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
          parameters: params
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

  describe '/get_products' do
    context 'success' do
      it 'generates a product:import for an imported product' do
        message = {
          parameters: params
        }.to_json

        VCR.use_cassette('import_product_success') do
          post '/get_products', message, auth
          last_response.status.should == 200
          last_response.body.should match /Imported products/
          last_response.body.should match /product:import/
        end
      end
    end
  end
end
