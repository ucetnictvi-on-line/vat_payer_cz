module VatInfo
  module Models
    class VatPayerExtended < VatPayer
      def initialize(params)
        super(params)

        @data[:nazev_subjektu]      = normalize(params[:nazev_subjektu])

        address                     = params.fetch(:adresa, {})
        @data[:ulice_cislo]         = normalize(address[:ulice_cislo])
        @data[:cast_obce]           = normalize(address[:cast_obce])
        @data[:mesto]               = normalize(address[:mesto])
        @data[:psc]                 = normalize(address[:psc])
        @data[:stat]                = address[:stat]
      rescue KeyError => e
        raise InvalidStructure, "Response XML is missing required attributes.\n" \
                                "Input params were: #{params}\n" \
                                "Rescued error: #{e}"
      end

      def normalize(string)
        VatInfo::Utils.normalize(string)
      end
    end
  end
end
