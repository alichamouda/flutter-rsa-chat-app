
import 'package:flutter/foundation.dart';

class UserInfo {
  String sn;
  String givenName;
  String displayName;
  String userPKCS12;

  UserInfo({
    @required this.sn,
    @required this.givenName,
    @required this.displayName,
    @required this.userPKCS12,

  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {

    final Map<String,dynamic> data = Map.castFrom<dynamic, dynamic, String, dynamic>(json['attributes']);

    return UserInfo(
      sn: data['sn'][0] as String,
      givenName: data['givenName'][0] as String,
      displayName: data['displayName'][0] as String,
      userPKCS12: data['userPKCS12'][0] as String,
    );
  }
}
