class AppConstants {
  // static const String BASE_URL = "http://127.0.0.1:8000";
  static const String BASE_URL = "http://192.168.68.103:8000";
  static const POPULAR_TYPE_ID = 2;
  static const RECOMMENDED_TYPE_ID = 3;
  static const String POPULAR_PRODUCT_URI = "/api/product-containers/type/${POPULAR_TYPE_ID}";
  static const String RECOMMENDED_PRODUCT_URI = "/api/product-containers/type/${RECOMMENDED_TYPE_ID}";

  static const int COUTNER_MAX_QUANTITY = 20;

  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "Cart-history-list";
  static const bool REMOVE_CACHE = false;

  //user and auth end points
  static const String REGISTRATION_URI = "/api/signup";
  static const String LOGIN_URI = "/api/login";
  static const String USER_INFO_URI = "/api/customer/info";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String USERNAME = "";
}