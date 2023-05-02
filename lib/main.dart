import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';
import 'front_end/start.dart';

Future<void> main() async {

  runApp(
    const MaterialApp(

      debugShowCheckedModeBanner: false,

      home: test_01(),

    )
  );

}

class test_01 extends StatefulWidget {
  const test_01({Key? key}) : super(key: key);

  @override
  State<test_01> createState() => _test_01State();
}

class _test_01State extends State<test_01> {


  void show_snacker_bar(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar) ;
  }

  Future send_email() async {
    final user = await GoogleAuthApi.sign_in() ;

    if (user == null) return ;

    final email = user.email ;
    final auth = await user.authentication ;
    final token = auth.accessToken ;

    final smtpServer = gmailSaslXoauth2(email , token!) ;
    final message = Message()
      ..from = Address(email , "yukta2k23@gmail.com")
      ..recipients = ['sarathipartha085@gmail.com']
      ..subject = 'hi'
      ..text = 'hi';

    try{
      await send(message, smtpServer) ;
      show_snacker_bar('Sent email Successfully!!!') ;
    } on MailerException catch (e) {
      print(e) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            send_email() ;
          },
          child: Center(
            child: Container(
              height: 50,
              width: 200,
              child: Text("send"),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleAuthApi {
  static final google_sign_in_ = GoogleSignIn(scopes: ['https://mail.google.com/']) ;

  static Future<GoogleSignInAccount?> sign_in() async {
    if (await google_sign_in_.isSignedIn()) {
      return google_sign_in_.currentUser ;
    }
    else {
      return google_sign_in_.signIn() ;
    }
  }

  static Future sign_out() => google_sign_in_.signOut() ;
}