module Factories
  def self.parameters
    [
      { 'name' => 'openerp.api_user',                   'value' => 'nothing' },
      { 'name' => 'openerp.api_password',               'value' => 'nothing' },
      { 'name' => 'openerp.api_database',               'value' => 'nothing' },
      { 'name' => 'openerp.api_url',                    'value' => 'nothing' },
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
