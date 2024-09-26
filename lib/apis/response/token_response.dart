
import 'dart:convert';

TokenResponse tokenRespFromJson(String str) => TokenResponse.fromJson(json.decode(str));

String tokenRespToJson(TokenResponse data) => json.encode(data.toJson());


class TokenResponse {
  String? status;
  String? message;

  TokenResponse({this.status, this.message});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    return data;
  }
}
