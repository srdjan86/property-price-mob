class Api {
  // static const String API_ROOT = 'https://property-price-server.herokuapp.com';
  static const String API_ROOT = 'http://192.168.1.73:3000';
  static const String CONTRACTS = '/contracts';
  static const String CONTRACTS_ENDPOINT = API_ROOT + CONTRACTS;
  static const String PROPERTY_TYPES = '/propertyTypes';
  static const String PROPERTY_TYPES_ENDPOINT = API_ROOT + PROPERTY_TYPES;
  static const String DISTRICTS = '/districts';
  static const String DISTRICTS_ENDPOINT = API_ROOT + DISTRICTS;
  static const String CADESTER_DISTRICTS = '/cadesterDistricts';
  static const String CADESTER_DISTRICTS_ENDPOINT =
      DISTRICTS_ENDPOINT + CADESTER_DISTRICTS;
}
