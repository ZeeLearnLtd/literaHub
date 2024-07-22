import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/core/constant/LocalConstant.dart';
import 'package:literahub/core/utility.dart';
import 'package:literahub/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = "";

  Future<dynamic> login({required String uid, required String password}) async {
    error = "";
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.containsKey('token') ? prefs.getString("token") as String : '';
      prefs.setString("uid", uid);
      prefs.setString("password", password);
      if (token.isEmpty) {
        await refresh();
        token = prefs.containsKey('token') ? prefs.getString("token") as String : '';
      }
      if(token.isNotEmpty){
        loginProcess(true);
        var loginResp = await LiteriaHubAPI.login(uid: uid, pwd: password,token: token);
        print('loginresp24 ${loginResp}');
        if (loginResp != null && loginResp is UserResponse) {
          //success //save data 
          var box = await Utility.openBox();
          print('in 32....');
            String json = jsonEncode(loginResp);
            print(json);
            box.put(LocalConstant.KEY_LOGIN_RESPONSE, json);
            box.put(LocalConstant.KEY_LOGIN_PASSWORD, password);
            box.put(LocalConstant.KEY_LOGIN_USERNAME, uid);
          final prefs = await SharedPreferences.getInstance();
          return loginResp as UserResponse;
          //prefs.setString("uid", loginResp.root!.subroot!.uid!);
        } else {
          error = loginResp;
          final prefs = await SharedPreferences.getInstance();
          prefs.clear();
        }
      }else{
        return "Invalid UserName and Password";
      }
      } finally {
        loginProcess(false);
      }
  
    return error;
  }

  Future<bool> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.containsKey('token') ? prefs.getString("token") as String : '';
    String uid = prefs.containsKey('uid') ? prefs.getString("uid") as String : '';
    String password = prefs.containsKey('password') ? prefs.getString("password") as String : '';

    if (token == null) {
      return false;
    }

    bool success = false;
    try {
      loginProcess(true);
      debugPrint('in refresh token...');
      var loginResp = await LiteriaHubAPI.refreshToken(uid: uid,pwd: password);
      debugPrint('loginResp  ${loginResp}');
      if (loginResp != "") {
        //success
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loginResp);
        success = true;
      }
    } finally {
      loginProcess(false);
    }
    return success;
  }
}