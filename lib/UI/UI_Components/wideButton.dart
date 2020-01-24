import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';

class WideButton extends StatefulWidget {
  const WideButton(this.content,{Key key}) : super(key: key);
  final String content;
  @override
  _WideButtonState createState() => _WideButtonState();
}

class _WideButtonState extends State<WideButton> {
  String content = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.skyBlue,
          borderRadius: new BorderRadius.all(Radius.circular(10.0))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.content,
            style: GoogleFonts.assistant(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
