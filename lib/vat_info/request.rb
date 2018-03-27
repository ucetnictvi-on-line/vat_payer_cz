require 'nokogiri'
require 'vat_info/request/unreliable_payer'
require 'vat_info/request/unreliable_payer_extended'

module VatInfo
  class Request
    SOAP_ENV_SCHEMA = 'http://schemas.xmlsoap.org/soap/envelope/'.freeze

    def envelope
      Nokogiri::XML::Builder.new('encoding' => 'UTF-8') do |xml|
        xml['soapenv'].Envelope('xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/') do
          xml['soapenv'].Body do
          end
        end
      end.doc
    end

    def to_xml
      msg  = envelope.dup
      body = msg.at_xpath('//soapenv:Body')
      body.add_child(self.body.root)

      msg.to_xml
    end
  end
end
