import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/controller/logincontroller.dart';
import 'package:literahub/core/constant/LocalConstant.dart';
import 'package:literahub/core/utility.dart';
import 'package:literahub/model/userinfo.dart';
import 'package:literahub/screens/auth/views/homepage.dart';
import 'package:literahub/screens/auth/views/login.dart';
import 'package:literahub/screens/home/home_screen.dart';

class HomeControlPage extends StatefulWidget {
  const HomeControlPage({super.key});

  @override
  _HomeControlPageState createState() => _HomeControlPageState();
}

class _HomeControlPageState extends State<HomeControlPage> {
  final LoginController controller = Get.put(LoginController());

  Future<Widget> goto() async {
    String? token = await UserModel.getToken();
    if (token != null) {
      bool refresh = await controller.refresh();
      if (refresh) {
        var box = await Utility.openBox();
        if(box.containsKey(LocalConstant.KEY_LOGIN_RESPONSE)){
          var userInfoBody = box.get(LocalConstant.KEY_LOGIN_RESPONSE);
          UserResponse userinfo = UserResponse.fromJson(
            json.decode(userInfoBody) as Map<String, dynamic>,
          );
           return HomePage(userInfo: userinfo,);
        }
        return LiteriaHubLoginPage();
      }
    }
    return LiteriaHubLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: goto(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(color:Colors.white, child: const Center(child: Text('')));
          } else {
            return snapshot.data!;
          }
        });
  }
}