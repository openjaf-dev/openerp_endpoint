module Factories
  def self.parameters
    [
      { 'name' => 'openerp.api_user',                   'value' => ENV['OERP_USER'] },
      { 'name' => 'openerp.api_password',               'value' => ENV['OERP_PASS'] },
      { 'name' => 'openerp.api_database',               'value' => ENV['OERP_DB'] },
      { 'name' => 'openerp.api_url',                    'value' => ENV['OERP_URL'] },
      { 'name' => 'openerp.shop',                       'value' => '1' },
      { 'name' => 'openerp.shipping_policy',            'value' => 'Deliver all products at once' },
      { 'name' => 'openerp.invoice_policy',             'value' => 'Before Delivery' },
      { 'name' => 'openerp.pricelist',                  'value' => 'Public Pricelist' },
      { 'name' => 'openerp.shipping_lookup',            'value' => [] }
    ]
  end

  def self.config
    Factories.parameters.each.inject({}) do |result, param|
      result.merge!(param['name'] => param['value'])
    end
  end
end
