import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  static const String BASE_URL = "http://127.0.0.1:8000";
  // static const String BASE_URL = "http://192.168.68.103:8000";
  static const POPULAR_TYPE_ID = 2;
  static const RECOMMENDED_TYPE_ID = 3;
  static const String POPULAR_PRODUCT_URI = "/api/product-containers/type/${POPULAR_TYPE_ID}";
  static const String RECOMMENDED_PRODUCT_URI = "/api/product-containers/type/${RECOMMENDED_TYPE_ID}";
  static const String GEOCODE_URI = "/api/config/geocode";
  static const String ZONE_URI = "/api/config/get-zone-id";
  static const String SEARCH_LOCATION_URI = "/api/config/auto_complete";
  static const String PLACE_DETAILS_URI = "/api/config/place_details";

  static const int COUTNER_MAX_QUANTITY = 20;
  static const int ALLOW_USER_SET_MAP_AFTER_SECONDS = 2;
  static const int GET_GPS_LOCATION_TIMEOUT = 2;
  static const int DELAY_FOR_GET_ZONE = 2;
  static const LatLng MAP_INITIAL_POSITION = LatLng(1.43431832155932, 103.7903622897778);

  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "Cart-history-list";
  static const bool REMOVE_CACHE = false;

  //user and auth end points
  static const String REGISTRATION_URI = "/api/signup";
  static const String LOGIN_URI = "/api/login";
  static const String USER_INFO_URI = "/api/customer/info";
  static const String ADD_USER_ADDRESS_URI = '/api/customer/addresses/add';
  static const String ADDRESS_LIST_URI = '/api/customer/addresses/list';

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String USERNAME = "";
  static const String USER_ADDRESS = "user_address";

  static const String STRIPE_PUBLISHABLE_KEY = "pk_test_51OMmDtCIn4X0lBeBLK9CzoJTEAFSW1GsDcgRsqV51THIZvp69k9yEVjTrEWFCm83YwLPQ95cwU4bPDbkCCEMGGJo00T4X5dyzx";
  static const String PAYMENT_CREATE_INTENT_URI = '/api/payment/create_intent';

  
}