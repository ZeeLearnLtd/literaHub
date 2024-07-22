import 'dart:convert';

//import 'package:cqaccount/Model/ErrorResp.dart';
//import 'package:cqaccount/Model/LoginResp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literahub/apis/response/errorresponse.dart';
import 'package:literahub/apis/response/token_response.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/core/constant/LocalConstant.dart';

class LiteriaHubAPI {
  static var client = http.Client();
  static var _baseURL = LocalConstant.BASE_URL;

  static Future<String> refreshToken({required String uid,required String pwd}) async {
    var response = await client.post(Uri.parse('$_baseURL/snltoken'), 
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
    body: jsonEncode(<String, String>{"uid": uid, "pwd": pwd}));
    debugPrint('in 18 ${_baseURL} ${response.body}');
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      var json = response.body;
      //status is success but not excepted result
      if (json.contains("Message") == false) {
        return "Invalid User Name and Password";
      }
      var loginRes = tokenRespFromJson(json);
      if (loginRes != null) {
        return loginRes.message!;
      } else {
        return "Invalid User Name and Password";
      }
    }else {
      var json = response.body;
      try{
        var errorResp = errorRespFromJson(json);
        if (errorResp == null) {
          return "Invalid User Name and Password";
        } else {
          return errorResp.error;
        }
      }catch(e){
        return "Invalid User Name and Password";
      }
    }
  }

  static Future<dynamic> login({required String uid, required String pwd,required String token}) async {
    var response = await client.post(Uri.parse('$_baseURL/slnlogin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : token
        },
        body: jsonEncode(<String, String>{"uid": uid, "pwd": pwd}));
        debugPrint('in loginAPi token ${token}');
    debugPrint('in 53 ${response.request!.url} ${response.body}');
    if (response.statusCode == 200) {
      var json = response.body;
      var loginRes = loginRespFromJson(json);
      if (loginRes != null) {
        return loginRes;
      } else {
        return 'Invalid User Name and Password';
      }
    } else {
      var json = response.body;
      if(json==null || json.trim().isEmpty){
        return 'Invalid UserName and Password';
      }else{
      print('json ${json}');
      var errorResp = errorRespFromJson(json);
      if (errorResp == null) {
        return 'Invalid UserName and Password';
      } else {
        return errorResp.error;
      }
      }
    }
  }
}