module OpenErp
  class ProductImporter
    class << self
      def run!
        products = ProductProduct.find(:all, :domain => ['waiting_spree_import', '=', true])
        result = []

        products.each do |product|
          result << ProductImporter.product_to_product_import_message(product)
          product.waiting_spree_import = false
          product.save
        end

      end

      def product_to_product_import_message(product)

      end
    end
  end
end
