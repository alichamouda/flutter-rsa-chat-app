import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/Models/message.dart';
import 'package:insat_chat/Models/userInfo.dart';
import 'package:insat_chat/UI/chatScroll.dart';

class UserItem extends StatelessWidget {
  UserItem(this.user, {Key key,this.messages,this.account,this.socketIO}) : super(key: key);

  final UserInfo user;
  final AccountInfo account;
  final SocketIO socketIO;
  final Map<String,List<Message>> messages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return ChatScroll(userInfo: user,
                account: account,
                messages:messages,
                socketIO: socketIO,
              );
            }
        ));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 7,
              spreadRadius: 0.25,
              offset: Offset(
                1.5,
                2.5,
              ),
            )
          ],
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topRight: const Radius.circular(40),
            bottomLeft: const Radius.circular(40),
            bottomRight: const Radius.circular(40),
            topLeft: const Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,10),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 6, 0),
                  child: Icon(Icons.supervised_user_circle,size: 50,color: MyColors.greyBlue,),
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(user.displayName == null ?'null':user.displayName,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.assistant(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: MyColors.darkBlue,
                          )
                      ),
                      Text(user.givenName == null ?'null':user.givenName,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.assistant(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: MyColors.skyBlue,
                          )),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
