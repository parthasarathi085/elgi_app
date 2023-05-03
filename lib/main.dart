import 'package:flutter/material.dart';
import 'back_end/send_sms_from_the_app.dart';
import 'front_end/start.dart';

Future<void> main() async {

  runApp(
    const MaterialApp(

      debugShowCheckedModeBanner: false,

      home: send_sms_from_the_app(),

    )
  );

}
