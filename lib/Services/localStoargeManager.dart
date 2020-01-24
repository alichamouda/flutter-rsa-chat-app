
import 'package:insat_chat/Models/accountInfo.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {

  LocalStorageManager._privateConstructor();
  static final LocalStorageManager instance = LocalStorageManager._privateConstructor();

  addAccount(AccountInfo accountInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accountInfo.toFullMapStorage().forEach((k,v){
      prefs.setString(k, v);
    });
  }
  Future<AccountInfo> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> accountMap = new Map<String,dynamic>();
    prefs.getKeys().forEach((k){
      accountMap.putIfAbsent(k, () => prefs.getString(k));
    });
    return new AccountInfo.fromMap(accountMap);
  }
}