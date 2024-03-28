import 'dart:convert';

import 'package:flutter/material.dart';
import '../../extensions.dart';
import '../../main.dart';
import '../../screens/login/login_screen.dart';
import 'routeConstant.dart';

class CustomRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    RoutingData routingData = settings.name!.getRoutingData;
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    );
    // return MaterialPageRoute(
    //   builder: (context) => const LoginScreen(),
    // );
  }
}
