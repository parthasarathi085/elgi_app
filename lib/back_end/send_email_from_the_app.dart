import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

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
