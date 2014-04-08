module Factories
  def self.parameters
    {
      'openerp_api_user'                   => ENV['OERP_USER'],
      'openerp_api_password'               => ENV['OERP_PASS'],
      'openerp_api_database'               => ENV['OERP_DB'],
      'openerp_api_url'                    => ENV['OERP_URL'],
      'openerp_shop'                       => '1',
      'openerp_shipping_policy'            => 'Deliver all products at once',
      'openerp_shipping_name'              => 'FREE CARRIER',
      'openerp_invoice_policy'             => 'Before Delivery',
      'openerp_pricelist'                  => 'Public Pricelist',
      'openerp_shipping_lookup'            => []
    }
  end

  def self.config
    Factories.parameters.each.inject({}) do |result, param|
      result.merge!(param['name'] => param['value'])
    end
  end
end
