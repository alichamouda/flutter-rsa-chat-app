import 'package:insat_chat/Models/accountInfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insat_chat/Models/MyConsts.dart';

class RegistrationService {
  RegistrationService._privateConstructor();

  static final RegistrationService instance =
      RegistrationService._privateConstructor();

  Future<String> addUser(AccountInfo accountInfo) async {
    http.Response res = await http.post(MyConsts.api + 'user',
        body: json.encode(accountInfo.toFullMap()));
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw "Can't add user";
    }
  }
  Future<bool> deleteUser(String username) async {
    http.Response res = await http.delete(MyConsts.api + 'user/'+username,);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw "Error deleting user with username " + username;
    }
  }
}
