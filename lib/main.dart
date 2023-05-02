import 'package:flutter/material.dart';
import 'front_end/start.dart';

Future<void> main() async {

  runApp(
    const MaterialApp(

      debugShowCheckedModeBanner: false,

      home: start(),

    )
  );

}
