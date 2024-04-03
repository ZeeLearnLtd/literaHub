import 'dart:convert';
import 'dart:io';

class TokenRequest {
  final String UserId;
  final String Password;

  TokenRequest({required this.UserId,required this.Password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uid': UserId,
      'pwd': Password,
    };
    return map;
  }
}
