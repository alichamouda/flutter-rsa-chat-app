import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';

class SettingsCard extends StatelessWidget {
  final String label;
  final String content;
  final IconData icon;
  final double contentSize;

  const SettingsCard({Key key, this.label, this.content, this.icon,this.contentSize=30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30 , 20,30, 0),
      child: Container(
          decoration: BoxDecoration(
            color: MyColors.grey,
            borderRadius: new BorderRadius.only(
              topRight: const Radius.circular(25),
              bottomLeft: const Radius.circular(40),
              bottomRight: const Radius.circular(40),
              topLeft: const Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Text(label,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.assistant(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topRight: const Radius.circular(0),
                    bottomLeft: const Radius.circular(40),
                    bottomRight: const Radius.circular(40),
                    topLeft: const Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 10, 10),
                  child: Text(content,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.assistant(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: MyColors.darkBlue,
                      )),
                ),
              ),
            ],
          )),
    );
  }
}
