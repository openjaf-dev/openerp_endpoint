require 'spec_helper'

ProductProduct = OpenStruct.new

describe OpenErp::ProductImporter do
  let(:product) do
    OpenStruct.new
  end

  describe '.run!' do
    context 'when there are products to import' do
      it 'returns an array of product:import messages' do
        ProductProduct.should_receive(:find).exactly(:once).and_return([product])
      end
    end

    context 'when there are no products to import' do
      it 'returns an empty array' do
        ProductProduct.should_receive(:find).exactly(:once).and_return([])
        result = described_class.run!
        result.should be_a Array
        result.should be_empty
      end
    end
  end
end
