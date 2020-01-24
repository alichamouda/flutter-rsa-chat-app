import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/UI/UI_Components/settingsCard.dart';

class Settings extends StatelessWidget {
  Settings( {Key key,this.user}) : super(key: key);

  final AccountInfo user;

  @override
  Widget build(BuildContext context) {

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.darkBlue,
                            borderRadius: new BorderRadius.only(
                              topRight: const Radius.circular(40),
                              bottomLeft: const Radius.circular(0),
                              bottomRight: const Radius.circular(40),
                              topLeft: const Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.arrow_back, size: 35,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                              'Settings',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.assistant(
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                color: MyColors.darkBlue,
                              )
                          )
                      ),
                    ),

                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [MyColors.greyBlue, MyColors.darkBlue]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,

                            blurRadius: 12,
                            spreadRadius:0.5,
                            offset: Offset(
                              3.5,
                              -2.5,
                            ),
                          )
                        ],
                        color: MyColors.grey,
                        borderRadius: new BorderRadius.only(
                          topRight: const Radius.circular(30),
                          bottomLeft: const Radius.circular(30),
                          bottomRight: const Radius.circular(30),
                          topLeft: const Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        children: <Widget>[
                          SettingsCard(label:'Username',content:user.sn,
                            icon: Icons.supervised_user_circle,),
                          SettingsCard(label:'Name',content:user.displayName,
                            icon: Icons.accessibility_new,),
                          SettingsCard(label:'Lastname',content:user.givenName,
                            icon: Icons.supervisor_account,),
                          SettingsCard(label:'uid',content:user.uid,
                            icon: Icons.email,),
                          SettingsCard(label:'Public Key',content:user.userPKCS12.substring(0,200)+'...',
                            icon: Icons.vpn_key,contentSize:20),
                          ],
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 7,
                          spreadRadius: 0.05,
                          offset: Offset(
                            3.5,
                            -2.5,
                          ),
                        )
                      ],
                      color: MyColors.grey,
                      borderRadius: new BorderRadius.only(
                        topRight: const Radius.circular(40),
                        bottomLeft: const Radius.circular(40),
                        bottomRight: const Radius.circular(40),
                        topLeft: const Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Revoke',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.assistant(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
