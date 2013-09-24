Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'      => 39.9161998,
      'longitude'     => -75.2860341,
      'address'       => '1234 Default Stub Street, Philadelphia, PA, 1901',
      'state'         => 'Pennsylvania',
      'state_code'    => 'PA',
      'country'       => 'United States',
      'country_code'  => 'US'
    }
  ]
)
