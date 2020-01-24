import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insat_chat/Models/MyConsts.dart';
import 'package:insat_chat/Models/accountInfo.dart';
import 'package:insat_chat/Services/localStoargeManager.dart';
import 'package:insat_chat/Services/registrationService.dart';
import 'package:insat_chat/Services/rsaService.dart';
import 'package:insat_chat/Services/socketService.dart';
import 'package:insat_chat/UI/loginPage.dart';
import 'package:asn1lib/asn1lib.dart';
import 'package:x509csr/x509csr.dart';
import 'UI_Components/card.dart';
import 'UI_Components/label.dart';
import 'UI_Components/textInput.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Map<String, dynamic> inputs = new Map<String, MyTextInput>();
  final List<Widget> formWidgets = new List<Widget>();
  final List<Widget> widgets = new List<Widget>();
  AccountInfo raccount;
  String buttonContent = 'Register';

  formBuilder() {
    inputs.putIfAbsent('Username', () => MyTextInput());
    inputs.putIfAbsent('Unique ID', () => MyTextInput());
    inputs.putIfAbsent('Given Name', () => MyTextInput());
    inputs.putIfAbsent('Display Name', () => MyTextInput());
    inputs.putIfAbsent(
        'Password',
        () => MyTextInput(
              password: true,
            ));

    inputs.forEach((k, v) {
      formWidgets.add(Label(content: k));
      formWidgets.add(v);
    });

    widgets.addAll(<Widget>[
      MyCard(title: 'Register', children: formWidgets),
      GestureDetector(
        onTap: () {
          Flushbar(
            title: "Registration",
            message: "Loading",
            margin: EdgeInsets.all(8),
            borderRadius: 20,
            duration: Duration(seconds: 10),
          )..show(context);
          register().then((onValue) {
            Flushbar(
              title: "Registration",
              margin: EdgeInsets.all(8),
              borderRadius: 20,
              message: "Done",
              duration: Duration(seconds: 6),
            )..show(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return LoginPage(raccount);
                }));
          });

        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.skyBlue,
                borderRadius: new BorderRadius.all(Radius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                buttonContent,
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
        ),
      ),
    ]);
  }

  Future<bool> register() async {
    await RSASpecialService.instance
        .computeRSAKeyPair(RSASpecialService.getSecureRandom())
        .then((keyPair) {
      ASN1ObjectIdentifier.registerFrequentNames();
      Map<String, String> dn = {
        "CN": inputs['Username'].getValue(),
        "O": "Consensas",
        "L": "Toronto",
        "ST": "Ontario",
        "C": "CA",
      };

      ASN1Object encodedCSR = makeRSACSR(dn, keyPair.privateKey, keyPair.publicKey);
      dynamic signedCertif = "";
      //      print(encodeCSRToPem(encodedCSR));
//      print(encodeRSAPublicKeyToPem(keyPair.publicKey));
//      print(encodeRSAPrivateKeyToPem(keyPair.privateKey));

      raccount = new AccountInfo(
        sn: inputs['Username'].getValue(),
        uid: inputs['Unique ID'].getValue(),
        userPassword: inputs['Password'].getValue(),
        givenName: inputs['Given Name'].getValue(),
        displayName: inputs['Display Name'].getValue(),
        userPKCS12: encodeRSAPublicKeyToPem(keyPair.publicKey),
        privateKey: encodeRSAPrivateKeyToPem(keyPair.privateKey),
        userSMIMECertificate: signedCertif,
      );

      RegistrationService.instance.addUser(raccount).then((s) {
        SocketService.instance.signCertif(encodeCSRToPem(encodedCSR)).then((a){
          raccount.userSMIMECertificate = a;
        });
      });


      LocalStorageManager.instance.addAccount(raccount);
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  @override
  void initState() {
    if (widgets.isEmpty) formBuilder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [MyColors.lightBlue, MyColors.darkBlue])),
            child: ListView.builder(
              itemCount: widgets.length,
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, i) {
                return widgets[i];
              },
            )),
      ),
    );
  }
}
