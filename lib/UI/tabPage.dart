import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/UI/loginPage.dart';
import 'package:insat_chat/UI/registerPage.dart';

class TabPage extends StatelessWidget {
  TabPage(this.pageController);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new Container(
              color: MyColors.darkBlue,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: MyColors.lightBlue,
                      tabs: [
                        Tab(icon: Icon(Icons.format_list_bulleted)),
                        Tab(icon: Icon(Icons.verified_user)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              RegisterPage(),
              LoginPage(AccountInfo(
                sn: 'alichamouda',
                displayName: 'Ali Hamouda',
                uid: 'idontknow',
                userPassword: 'zaeraze',
                userPKCS12: 'azeazeaze',
                givenName: 'Ali',
              )),
            ],
          ),
        ),
      ),
    );
  }
}
