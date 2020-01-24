import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insat_chat/Models/MyConsts.dart';

class SocketService {

  SocketService._privateConstructor();
  static final SocketService instance =
  SocketService._privateConstructor();


  Future<String> signCertif(certif) async {

    String c = certif;
    c.replaceAll(" ","");
    http.Response res = await http.post(MyConsts.api + 'sign',
        body:utf8.encode(certif),
        );

    var certiffff = base64Encode(res.bodyBytes);
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw "Can't send certif";
    }
  }
}
