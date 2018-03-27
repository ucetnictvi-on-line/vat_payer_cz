require 'pry'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require_relative '../lib/vat_info'
require 'vcr'
require 'nokogiri'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

Dir[File.join('.', '/spec/shared/**/*.rb')].each { |f| require f }

RSpec::Matchers.define :have_xml do |xpath, text|
  match do |body|
    nodes = body.xpath(xpath)
    expect(nodes.empty?).to be false
    if text
      nodes.each do |node|
        expect(node.content).to eq text
      end
    end
    true
  end

  failure_message do |body|
    "expected to find xml tag #{xpath} in:\n#{body}"
  end

  failure_message_when_negated do |body|
    "expected not to find xml tag #{xpath} in:\n#{body}"
  end

  description do
    "have xml tag #{xpath}"
  end
end
