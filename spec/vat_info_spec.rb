require 'spec_helper'

describe VatInfo do
  let(:payers) do
    [
      'CZ00550655', 'CZ25374320', 'CZ7505273457', 'CZ26585065', 'CZ28051190', 'CZ45280096', 'CZ25434675',
      'CZ7455110278', 'CZ26472546', 'CZ530615134', 'CZ49240056', 'CZ27653048', 'CZ7060023168', 'CZ8109242746',
      'CZ26116715', 'CZ26769671', 'CZ26132699', 'CZ27385906', 'CZ27649270', 'CZ43874860', 'CZ64259374',
      'CZ27470717', 'CZ61054623', 'CZ25719416', 'CZ6905090324', 'CZ6604120996', 'CZ61853437', 'CZ26505525',
      'CZ5505040211', 'CZ6308060847', 'CZ530703134', 'CZ26731622', 'CZ7707202041', 'CZ26447401',
      'CZ7053210285', 'CZ27074765', 'CZ7411161021', 'CZ41191943', 'CZ26409798', 'CZ45357099', 'CZ8854074152'
    ]
  end

  it 'has a version number' do
    expect(VatInfo::VERSION).not_to be nil
  end

  describe '#unreliable_payer' do
    it 'fetches data about VAT payers' do
      VCR.use_cassette('vat_info_unreliable_payer_bulk') do
        response = VatInfo.unreliable_payer(*payers)

        expect(response).to be_a VatInfo::Response
        expect(response.status_code).to eq 200
      end
    end
  end

  describe '#unreliable_payer_extended' do
    it 'fetches extended data about VAT payers' do
      VCR.use_cassette('vat_info_unreliable_payer_extended_bulk') do
        response = VatInfo.unreliable_payer_extended(*payers)

        expect(response).to be_a VatInfo::Response
        expect(response.status_code).to eq 200
      end
    end
  end
end
