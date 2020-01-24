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
  PageController _pageController;

  Widget select = MaterialApp(
      home: Scaffold());

  @override
  void initState(){
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
//          select = LoginPage(new AccountInfo(sn: '', userPassword: '', uid: '', givenName: '', displayName: '', userPKCS12: '', privateKey: '', certif: ''));
        });

      }else {
        setState(() {
          select = RegisterPage();
        });
      }
    });

    //return TabPage(_pageController);
    return MaterialApp(
      home: select,
    );
  }



//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        body: PageView(
//          controller: _pageController,
//          children: [
//            Container(
//              color: Colors.red,
//              child: Center(
//                child: RaisedButton(
//                  color: Colors.white,
//                  onPressed: () {
//                    if (_pageController.hasClients) {
//                      _pageController.animateToPage(
//                        1,
//                        duration: const Duration(milliseconds: 400),
//                        curve: Curves.easeInOut,
//                      );
//                    }
//                  },
//                  child: Text('Next'),
//                ),
//              ),
//            ),
//            Container(
//              color: Colors.blue,
//              child: Center(
//                child: RaisedButton(
//                  color: Colors.white,
//                  onPressed: () {
//                    if (_pageController.hasClients) {
//                      _pageController.animateToPage(
//                        0,
//                        duration: const Duration(milliseconds: 400),
//                        curve: Curves.easeInOut,
//                      );
//                    }
//                  },
//                  child: Text('Previous'),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
}

