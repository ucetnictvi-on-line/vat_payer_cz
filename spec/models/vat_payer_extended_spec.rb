require 'spec_helper'

RSpec.describe VatInfo::Models::VatPayerExtended do
  describe '.new' do
    it 'creates VatPayer hash in correct structure' do
      params = VCR.use_cassette('vat_payer_extended_data') do
        response = VatInfo.unreliable_payer_extended('CZ26168685')
        response.raw
      end[:status_nespolehlivy_platce_rozsireny_response][:status_platce_dph]

      vat_payer = VatInfo::Models::VatPayerExtended.new(params).data

      expect(vat_payer[:cislo_fu]).to eq '13'
      expect(vat_payer[:nespolehlivy_platce]).to eq 'NE'
      expect(vat_payer[:dic]).to eq 'CZ26168685'
      expect(vat_payer[:ucty].size).to eq 9
      expect(vat_payer[:ucty].first[:cislo]).to eq '2202295563'
      expect(vat_payer[:ucty].first[:iban]).to be_nil
      expect(vat_payer[:ucty].last[:cislo]).to be_nil
      expect(vat_payer[:ucty].last[:iban]).to eq 'CZ6555000000005080019993'
      expect(vat_payer[:nazev_subjektu]).to eq 'Seznam.cz, a.s.'
      expect(vat_payer[:ulice_cislo]).to eq 'Radlická 3294/10'
      expect(vat_payer[:cast_obce]).to eq 'Smíchov'
      expect(vat_payer[:mesto]).to eq 'Praha 5'
      expect(vat_payer[:psc]).to eq '15000'
      expect(vat_payer[:stat]).to eq 'Česká republika'
    end

    it 'raises InvalidStructure exception if input does not contain mandatory data' do
      expect { VatInfo::Models::VatPayerExtended.new(a: 1) }.to raise_error(VatInfo::Models::InvalidStructure)
    end
  end
end
