import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextInput extends StatefulWidget {
  MyTextInput({Key key,this.password = false,this.defaultStr = ''}) : super(key: key);

  getValue(){
   return textEditingController.text.trim();
  }
  final bool password;
  final String defaultStr;
  final TextEditingController textEditingController = new TextEditingController();

  @override
  _TextInputState createState() => _TextInputState(textEditingController,password,defaultStr);
}

class _TextInputState extends State<MyTextInput> {

  final TextEditingController textEditingController;
  bool password ;
  String defaultStr;
  _TextInputState(this.textEditingController,this.password,this.defaultStr);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    this.textEditingController.text = this.defaultStr;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: password,
      style: GoogleFonts.assistant(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 6, 0, 20),
          border: InputBorder.none,
          hintText: 'Write ...'),
    );
  }
}
