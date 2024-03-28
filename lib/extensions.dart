import 'package:flutter/material.dart';

class RoutingData {
  final String route;
  final Map<String, String> _queryParameters;

  RoutingData({
    required this.route,
    required Map<String, String> queryParameters,
  }) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    debugPrint(
        'queryParameters: ${uriData.queryParameters} path:${uriData.path} host is :- ${uriData.host} and complete data is - ${uriData.fragment.toString()}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}

// Our design contains Neumorphism design and i made a extention for it
// We can apply it on any  widget

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}
