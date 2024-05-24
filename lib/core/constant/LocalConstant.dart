class LocalConstant {
  static const int PAGE_ALL_TICKET = 0;
  static const int PAGE_OVERDUE_TICKET = 1;
  static const int PAGE_POTENTIALS_TICKET = 2;
  static const int PAGE_OPEN_TICKET = 3;
  static const int PAGE_PRIORITY_TICKET = 4;
  static const int PAGE_INPROGRESS_TICKET = 5;

  static double defaultPadding = 16.0;

  static String notificationTopicName = 'saathi';
  static const String LITERAHUB = "literahub";

  static const flavor = "MLL";

  static const String KEY_LOGIN_RESPONSE = "userinfo";

  static const String BASE_URL = "https://globalapi.zeelearn.com/api/V1/";
  static const String FRADOM_BASE_URL = "https://stage.api.getfreadom.com";

  static const String API_GET_TOKEN = "snltoken";
  static const String API_GET_LOGIN = "slnlogin";
  static const String API_GET_FRADOMDEEPLINK =
      "/api/user/v1/generate-deeplink/";
}
