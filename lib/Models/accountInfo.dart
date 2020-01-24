import 'package:flutter/foundation.dart';

class AccountInfo {
  String sn;
  String userPassword;
  String uid;
  String givenName;
  String displayName;
  String userPKCS12;
  String privateKey;
  String userSMIMECertificate;

  AccountInfo({
    @required this.sn,
    @required this.userPassword,
    @required this.uid,
    @required this.givenName,
    @required this.displayName,
    @required this.userPKCS12,
    @required this.privateKey,
    @required this.userSMIMECertificate,
  });

  Map<String, dynamic> toFullMap() {
    return {
      'givenName': givenName,
      'sn': sn,
      'userPassword': userPassword,
      'uid': uid,
      'displayName': displayName,
      'userPKCS12': userPKCS12,
      'userSMIMECertificate': userSMIMECertificate,
    };
  }
  Map<String, dynamic> toFullMapStorage() {
    return {
      'givenName': givenName,
      'sn': sn,
      'userPassword': userPassword,
      'uid': uid,
      'displayName': displayName,
      'userPKCS12': userPKCS12,
      'privateKey':privateKey,
      'userSMIMECertificate': userSMIMECertificate,
    };
  }

  factory AccountInfo.fromJson(Map<String, dynamic> data) {
    final Map<String, dynamic> json =
        Map.castFrom<dynamic, dynamic, String, dynamic>(data['attributes']);

    return AccountInfo(
      givenName: json['givenName'][0] as String,
      displayName: json['displayName'][0] as String,
      userPKCS12: json['userPKCS12'][0] as String,
      userPassword: json['userPassword'][0] as String,
      sn: json['sn'][0] as String,
      uid: json['uid'][0] as String,
      userSMIMECertificate: data['userSMIMECertificate'][0] as String,
    );
  }

  factory AccountInfo.fromMap(Map<String, dynamic> data) {

    return AccountInfo(
      givenName: data['givenName'] as String,
      displayName: data['displayName']as String,
      userPKCS12: data['userPKCS12']as String,
      userPassword: data['userPassword'] as String,
      sn: data['sn'] as String,
      uid: data['uid'] as String,
      privateKey: data['privateKey'] as String,
      userSMIMECertificate: data['userSMIMECertificate'] as String,
    );
  }
}
