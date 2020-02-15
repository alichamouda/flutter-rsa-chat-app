import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/Models/message.dart';
import 'package:insat_chat/Models/userInfo.dart';
import 'package:insat_chat/UI/UI_Components/recievedMessage.dart';
import 'package:insat_chat/UI/UI_Components/sentMessage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ChatScroll extends StatefulWidget {
  final UserInfo userInfo;
  final AccountInfo account;
  final SocketIO socketIO;
  final Map<String,List<Message>> messages;
  ChatScroll({Key key, this.userInfo, this.account,this.messages,this.socketIO}) : super(key: key);

  @override
  _ChatScrollState createState() =>
      new _ChatScrollState(userInfo, this.account,this.messages,this.socketIO);
}

class _ChatScrollState extends State<ChatScroll> {
  final Map<String,List<Message>> messages;
  final UserInfo userInfo;
  SocketIO socketIO;
  final AccountInfo account;

  @override
  void initState() {
    messageController = TextEditingController();
//    initSocket();
    super.initState();
  }

  TextEditingController messageController;

  _ChatScrollState(this.userInfo, this.account,this.messages,this.socketIO);

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color.fromRGBO(240, 240, 240, 1)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
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
                            child: Icon(Icons.arrow_back,
                                size: 35, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(userInfo.displayName,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.assistant(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: MyColors.darkBlue,
                              ))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages[userInfo.sn].length,
                  reverse: true,
                  itemBuilder: (context, i) {
                    if (messages[userInfo.sn][i].source == account.sn)
                      return SentMessage(message: messages[userInfo.sn][i]);
                    return ReceivedMessage(message: messages[userInfo.sn][i]);
                  },
                ),
              ),
              Container(
                color: MyColors.skyBlue,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(60))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
                            child: TextField(
                              controller: messageController,
                              style: GoogleFonts.assistant(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 2, 0, 2),
                                  border: InputBorder.none,
                                  hintText: 'Write message'),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (messageController.value.text.trim() != '') {
                                final pkey = encrypt.RSAKeyParser().parse(account.privateKey);
                                final pubkey = encrypt.RSAKeyParser().parse(userInfo.userPKCS12);
                                final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: pubkey, privateKey: pkey));
                                final encrypted = encrypter.encrypt(messageController.value.text.trim());

                                  var strMsg = '{"data":"' +
                                      encrypted.base64 +
                                      '","receiver":"' +
                                      userInfo.sn +
                                      '","source":"' +
                                      account.sn +
                                      '","time":"12/12/2008"}';
                                  var strMsga = '{"data":"' +
                                      messageController.value.text.trim() +
                                      '","receiver":"' +
                                      userInfo.sn +
                                      '","source":"' +
                                      account.sn +
                                      '","time":"12/12/2008"}';
                                  socketIO.emit("custom_send", ["" + strMsg]);
                                  messages[userInfo.sn].insert(0,
                                      new Message.fromJson(jsonDecode(strMsga)));
                                  messageController.value =
                                      TextEditingValue(text: '');
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(60)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.send,
                                  color: MyColors.skyBlue,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
