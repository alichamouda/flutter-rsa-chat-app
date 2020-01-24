import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/Models/message.dart';
import 'package:insat_chat/Models/userInfo.dart';
import 'package:insat_chat/Services/rsaService.dart';
import 'package:insat_chat/UI/UI_Components/userItem.dart';
import 'package:insat_chat/UI/settings.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class UserList extends StatefulWidget {
  UserList({Key key, this.users, this.account}) : super(key: key);
  final List<UserInfo> users;
  final AccountInfo account;

  @override
  _UserListState createState() => _UserListState(this.users, this.account);
}

class _UserListState extends State<UserList> {
  List<UserInfo> users;
  AccountInfo account;
  SocketIOManager manager = SocketIOManager();
  SocketIO socketIO;
  Map<String,List<Message>> messages = new Map<String,List<Message>>();
  _UserListState(this.users, this.account);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    users.removeWhere((user)=>user.sn == account.sn );
    users.forEach((user){
      this.messages.putIfAbsent(user.sn, () => new List<Message>());
    });
    initSocket();
    super.initState();
  }

  initSocket() async {
    socketIO = await manager.createInstance(
        SocketOptions(MyConsts.api, transports: [Transports.POLLING]));
    socketIO.onConnect((data) {
      print("connected...");
      print(data);
    });
    socketIO.onConnectError(pprint);
    socketIO.onConnectTimeout(pprint);
    socketIO.onError(pprint);
    socketIO.onDisconnect(pprint);
    socketIO.on("custom_receive", addMessage);
    socketIO.connect();
  }

  pprint(data) {
    print(data);
  }

  addMessage(data) {



    var cipher = base64Decode(
        data.toString().split(",")[0].split(":")[1].trim());

    print(cipher.length);
    var decrypted = RSASpecialService.cipherToString(RSASpecialService.decryptStringPem(
        account.userPKCS12, account.privateKey, cipher));
    if(decrypted.length >0){
      Message msg = new Message(decrypted,
        data.toString().split(",")[1].split(":")[1].trim(),
        data.toString().split(",")[2].split(":")[1].trim(),
        data.toString().split(",")[3].split(":")[1].trim(),
      );
      this.messages[msg.source].insert(0,msg);
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        title: ""+msg.source,
        message: ""+decrypted.toString(),
        margin: EdgeInsets.all(8),
        borderRadius: 20,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 6,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text('Chatroom',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.assistant(
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                                fontStyle: FontStyle.normal,
                                color: MyColors.darkBlue,
                                ))),
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                            return Settings(
                              user: account,
                            );
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.darkBlue,
                            borderRadius: new BorderRadius.only(
                              topRight: const Radius.circular(0),
                              bottomLeft: const Radius.circular(40),
                              bottomRight: const Radius.circular(0),
                              topLeft: const Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.settings,
                                size: 35, color: Colors.white),
                          ),
                        ),
                      ),
                    )
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
                            spreadRadius: 0.5,
                            offset: Offset(
                              3.5,
                              -2.5,
                            ),
                          )
                        ],
                        color: MyColors.grey,
                        borderRadius: new BorderRadius.only(
                          topRight: const Radius.circular(40),
                          bottomLeft: const Radius.circular(0),
                          bottomRight: const Radius.circular(0),
                          topLeft: const Radius.circular(40),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: users.length,
                        padding: const EdgeInsets.all(10.0),
                        itemBuilder: (context, i) {
                          return UserItem(
                            users[i],
                            account: account,
                              messages:messages,
                            socketIO:socketIO,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
