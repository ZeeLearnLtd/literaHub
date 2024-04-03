import 'package:literahub/apis/request/token_request.dart';
import 'package:literahub/apis/response/token_response.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/iface/onResponse.dart';

import 'APIService.dart';

class ApiServiceHandler {
  static int API_STATUS_SUCCESS = 200;
  static int API_STATUS_ERROR= 400;

  void getToken(TokenRequest requestModel,onResponse response) {
    APIService apiService = APIService();
    response.onStart();
    apiService.getToken(requestModel).then((value) {
      if (value != null) {
        TokenResponse tokenResponse;
        if (value != null) {
          tokenResponse = value;
          response.onSuccess(tokenResponse);
        } else {
          response.onError(API_STATUS_ERROR,'Unable to get token');
        }
      } else {
        response.onError(API_STATUS_ERROR,'Unable to get token');
      }
    });
  }
  void validateUser(TokenRequest requestModel,String token,onResponse response) {
    APIService apiService = APIService();
    response.onStart();
    apiService.validateUser(requestModel,token).then((value) {
      if (value != null) {
        UserResponse userResponse;
        if (value != null) {
          userResponse = value;
          response.onSuccess(userResponse);
        } else {
          response.onError(API_STATUS_ERROR,'Unable to get token');
        }
      } else {
        response.onError(API_STATUS_ERROR,'Unable to get token');
      }
    });
  }

}
