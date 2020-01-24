import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';

class MyCard extends StatelessWidget {
  MyCard({ Key key, this.title, this.children }) : super(key: key) {
    this.children.insert(0, Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Text(
            title,
            textAlign: TextAlign.left,
            style: GoogleFonts.assistant(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: MyColors.greyBlue,
            )
        )
    ));
  }

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: MyColors.greyBlue,
            blurRadius: 25.0,
            // has the effect of softening the shadow
            spreadRadius: 10.0,
            // has the effect of extending the shadow
            offset: Offset(
              3.0, // horizontal, move right 10
              6.0, // vertical, move down 10
            ),
          )
        ],
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topRight: const Radius.circular(10.0),
          bottomLeft: const Radius.circular(10.0),
          bottomRight: const Radius.circular(10.0),
          topLeft: const Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children
        ),
      ),
    );
  }
}