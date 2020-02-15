import 'package:flutter/material.dart';
import 'package:insat_chat/Services/localStoargeManager.dart';
import 'package:insat_chat/UI/loginPage.dart';
import 'package:insat_chat/UI/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  Widget select = MaterialApp(
      home: Scaffold());

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then( (prefs) {
      if(prefs.getKeys().isNotEmpty){
        setState(() {
          LocalStorageManager.instance.getAccount().then((acc){
            select = LoginPage(acc);
          });
        });

      }else {
        setState(() {
          select = RegisterPage();
        });
      }
    });

    return MaterialApp(
      home: select,
    );
  }

}

