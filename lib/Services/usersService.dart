import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/userInfo.dart';

class UsersService {

  UsersService._privateConstructor();
  static final UsersService  instance = UsersService ._privateConstructor();

  Future<List<UserInfo>> getAllUsers(username,password) async {
    var data = json.encode({
      'username': username,
      'password': password
    });
    http.Response res = await http.post(MyConsts.api+ 'loginDart',
        body:data ,
        headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      print(body.runtimeType.toString());
      List<UserInfo> users = body
          .map((dynamic item) => UserInfo.fromJson(item),)
          .toList();

      return users;
    } else {
      throw "can t get userlist";
    }
  }
}
