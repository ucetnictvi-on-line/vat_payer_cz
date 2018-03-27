# VAT payer info CZ
This is Ruby wrapper for [web service for "searching information about reliability of VAT payers and their bank accounts" of Czech Republic Ministry of finance.](http://www.etrzby.cz/cs/index)

## Installation
`gem install 'vat_payer_cz'`

## Usage
The web service has the following three end-points:
- [standard VAT payer info](#standard)
- [extended VAT payer info](#extended)
- list of unreliable VAT payers (not implemented)

This gem currently implements **standard VAT payer info** and **extended VAT payer info**.

## <a name="standard">Standard VAT payer info</a>
```ruby
require 'vat_info'

vat_ids = %w(CZ27169278 CZ26168685)
VatInfo.unreliable_payer(*vat_ids)
```
## <a name="extended">Extended VAT payer info</a>
Compared to Standard VAT payer info, the response is enriched by other VAT payer data, such as name and address.
The library normalizes some of the VAT payer attributes which are supplied in capitals (company name and address attributes).
```ruby
require 'vat_info'

vat_ids = %w(CZ27169278 CZ26168685)
VatInfo.unreliable_payer_extended(*vat_ids)
```

## Response
Object `VatInfo::Response`

#### Example
```shell
=> #<VatInfo::Response:0x0000000001ff61e8
 @body=
  {:status=>{:status_code=>"0", :status_text=>"OK", :odpoved_generovana=>"2018-02-08"},
   :platci=>
    [{:nespolehlivy_platce=>"NE",
      :datum_zverejneni=>nil,
      :dic=>"CZ27169278",
      :cislo_fu=>"451",
      :ucty=>
       [{:predcisli=>nil, :cislo=>"1041150202", :kod_banky=>"5500", :iban=>nil, :datum_zverejneni=>"2013-04-01"},
        {:predcisli=>nil, :cislo=>"6021446666", :kod_banky=>"6000", :iban=>nil, :datum_zverejneni=>"2013-12-05"},
        {:predcisli=>nil, :cislo=>"2400915487", :kod_banky=>"2010", :iban=>nil, :datum_zverejneni=>"2016-05-05"}]},
...
```
### .status_code
`VatInfo::Response.status_code => String`
200 - OK: Valid response was received.
408 - Request Timeout: the web service timed out.
503 - Service Unavailable: there was another error fetching the response.

### .body
Empty attributes have `nil` value.

`VatInfo::Response.body => Hash`
```ruby
{
  status: { Status }
  platci: [ { Payer | PayerExtended }, .. ]
}
```

### .raw
Raw data returned by the web service.

#### Status
See official docs for explanation.
```ruby
{
  status_code: String,
  status_text: String,
  odpoved_generovana: String # ISO 8601 Date
}
```
#### Payer
```ruby
{
  nespolehlivy_platce: String, # "ANO" | "NE" | "NENALEZEN"
  datum_zverejneni: String, # ISO 8601 Date
  dic: String,
  cislo_fu: String,
  ucty: [ { Account }, .. ]
}
```
#### PayerExtended
```ruby
{
  nespolehlivy_platce: String, # "ANO" | "NE" | "NENALEZEN"
  datum_zverejneni: String, # ISO 8601 Date
  dic: String,
  cislo_fu: String,
  ucty: [ { Account }, .. ]
  
  #Extended info
  nazev_subjektu: String,
  ulice_cislo: String,
  cast_obce: String,
  mesto: String,
  psc: String,
  stat: String
}
```
#### Account
```ruby
{
  predcisli: String, # only Czech accounts
  cislo: String, # only Czech accounts
  kod_banky: String, # only Czech accounts
  iban: String # Czech and foreign accounts
}
```

## Schema changes
The client will raise `VatInfo::SchemaError` exception if it thinks the schema have changed.

## Official web service docs
In Czech: https://adisspr.mfcr.cz/adistc/adis/idpr_pub/dpr_info/ws_spdph.faces
