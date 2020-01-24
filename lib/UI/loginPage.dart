import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/Services/registrationService.dart';
import 'package:insat_chat/Services/usersService.dart';
import 'package:insat_chat/UI/UI_Components/card.dart';
import 'package:insat_chat/UI/UI_Components/label.dart';
import 'package:insat_chat/UI/UI_Components/textInput.dart';
import 'package:insat_chat/UI/UI_Components/wideButton.dart';
import 'package:insat_chat/UI/registerPage.dart';
import 'package:insat_chat/UI/userList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.accountInfo, {Key key}) : super(key: key);
  final AccountInfo accountInfo;

  @override
  _LoginPageState createState() => _LoginPageState(accountInfo);
}

class _LoginPageState extends State<LoginPage> {
  final AccountInfo accountInfo;
  _LoginPageState(this.accountInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [MyColors.lightBlue, MyColors.darkBlue])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MyCard(title: 'Login', children: <Widget>[
                Label(content: 'Username'),
                MyTextInput(defaultStr: accountInfo.sn,),
                Label(content: 'Password'),
                MyTextInput(defaultStr: accountInfo.userPassword,password: true,),
              ]),
              GestureDetector(
                onTap: () {// RSASpecialService.test();
                  UsersService.instance.getAllUsers(accountInfo.sn,accountInfo.userPassword)
                      .then((users){

                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return UserList(users:users,account:accountInfo);
                        }
                    ));
                  }).timeout(Duration(seconds: 10)).catchError((error){
                    print(error);
                    Flushbar(
                      title: "Login",
                      margin: EdgeInsets.all(8),
                      borderRadius: 20,
                      backgroundColor: Colors.red,
                      message: "error",
                      duration: Duration(seconds: 4),
                    )..show(context);
                  });

                },
                child: WideButton('Connect'),
              ),
              GestureDetector(
                onTap: () {
                  SharedPreferences.getInstance().then((pref){
                    RegistrationService.instance
                        .deleteUser(pref.get('sn'))
                        .then((b){
                      if(b)
                        pref.clear().then((v){});
                    });
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return RegisterPage();
                      }
                  ));
                },
                child: WideButton('Clear Cache'),
              ),
            ],
          )),
    );
  }
}
