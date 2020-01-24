import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';

class Label extends StatelessWidget {
  const Label({ Key key, this.content,this.fontSize = 25 ,this.color = MyColors.darkBlue}) : super(key: key);

  final String content;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return  Text(
      content,
      style: GoogleFonts.assistant(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}