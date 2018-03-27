module VatInfo
  module Models
    class VatPayers
      attr_accessor :data

      def initialize(model, params = {})
        @data          = {}
        @data[:platci] = create_vat_payers(model, params)
      end

      def create_vat_payers(model, payers)
        payers.map { |payer| model.new(payer).data }
      end
    end
  end
end
