import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:literahub/apis/request/fradomdeeplink.dart';
import 'package:literahub/apis/response/fradom_response.dart';
import 'package:literahub/apis/response/token_response.dart';
import 'package:literahub/apis/request/token_request.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/core/constant/LocalConstant.dart';


class APIService {
  String url = LocalConstant.BASE_URL;
  String fradom_url = LocalConstant.FRADOM_BASE_URL;

  APIService() {
    print('-------------------------APIServie');
    init();
  }
  init() async {
    
  }

  print(Object? value) {
    debugPrint(value.toString());
  }

getHeader(){
  return {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
          };
}

  getHeader1(){
    return {
      "Content-Type": "application/json"
    };
  }
getAuthHeader(String token){
  return {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": token,
          };
}
  

  Future<TokenResponse?> getToken(TokenRequest requestModel) async {
    try {
      await init();
      print(requestModel.toJson());
      print(Uri.parse(url + LocalConstant.API_GET_TOKEN));
      final response = await http.post(Uri.parse(url + LocalConstant.API_GET_TOKEN),
          headers: getHeader(),
          body: requestModel.toJson());
      //print(response.body);
      print('status code ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 400) {
        debugPrint('response received ${response.body}');
        return TokenResponse.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        return null;
      }
    } catch (e) {
      //print(e.toString());
      e.toString();
    }
    return null;
  }

  Future<UserResponse?> validateUser(TokenRequest requestModel,String token) async {
    try {
      await init();
      print(requestModel.toJson());
      print(Uri.parse(url + LocalConstant.API_GET_LOGIN));
      final response = await http.post(Uri.parse(url + LocalConstant.API_GET_LOGIN),
          headers: getAuthHeader(token),
          body: requestModel.toJson());
      //print(response.body);
      print('status code ${response.statusCode}');
      if (response.statusCode == 200 ) {
        debugPrint('response received ${response.body}');
        return UserResponse.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      e.toString();
    }
    return null;
  }

  Future<FradomLinkResponse?> getFradomDeeplink(GetFradomDeepLink requestModel) async {
    try {
      await init();
      print(requestModel.toJson());
      print(Uri.parse(fradom_url + LocalConstant.API_GET_FRADOMDEEPLINK));
      final response = await http.post(Uri.parse(fradom_url + LocalConstant.API_GET_FRADOMDEEPLINK),
          headers: getHeader1(),
          body: requestModel.toJson());
      if (response.statusCode == 200 || response.statusCode == 400) {
        debugPrint('response received ${response.body}');
        return FradomLinkResponse.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        debugPrint('response received ${response.body}');
        return null;
      }
    } catch (e) {
      print(e.toString());
      e.toString();
    }
    return null;
  }

}
