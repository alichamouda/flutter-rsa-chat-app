import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/message.dart';

class ReceivedMessage extends StatelessWidget {
  ReceivedMessage({Key key,this.message,}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            margin: EdgeInsets.fromLTRB(0, 5, 50, 10),
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white70,
                  blurRadius: 10.0,
                  spreadRadius: 3.0,
                  offset: Offset(
                    1.5,
                    3.0,
                  ),
                )
              ],
              color: MyColors.darkBlue,
              borderRadius: new BorderRadius.only(
                topRight: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(message.data,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.assistant(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  )),
            ),
          ),
        ]);
  }
}
