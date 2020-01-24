import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/Services/localStoargeManager.dart';

class AccountService {

  AccountService._privateConstructor();
  static final AccountService instance = AccountService._privateConstructor();

  void addAccountToLocalStorage(AccountInfo accountInfo) {
    LocalStorageManager.instance.addAccount(accountInfo);
  }

}