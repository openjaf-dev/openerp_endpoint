require 'spec_helper'

describe OpenErp::ProductImporter do
  before(:all) do
    VCR.use_cassette('ooor') do
      Ooor.new url: ENV['OERP_URL'],
               database: ENV['OERP_DB'],
               username: ENV['OERP_USER'],
               password: ENV['OERP_PASS']
    end
  end

  describe '.run!' do
  end
end
