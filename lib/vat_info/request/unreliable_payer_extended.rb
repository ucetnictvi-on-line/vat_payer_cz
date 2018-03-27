module VatInfo
  class Request
    class UnreliablePayerExtended < VatInfo::Request
      attr_accessor :vat_ids

      def initialize(*vat_ids)
        self.vat_ids = vat_ids
      end

      def body
        Nokogiri::XML::Builder.new('encoding' => 'UTF-8') do |xml|
          xml.StatusNespolehlivyPlatceRozsirenyRequest(xmlns: 'http://adis.mfcr.cz/rozhraniCRPDPH/') do
            vat_ids.each { |vat_id| xml.dic(vat_id) }
          end
        end.doc
      end
    end
  end
end
