import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class send_sms_from_the_app {
  check() async {
    if (await _isPermissionGranted()) {
      if ((await _supportCustomSim)!)
        _sendMessage("8144663240", "Hello", simSlot: 1);
      else
        _sendMessage("770885522", "Hello");
    } else
      _getPermission();
  }

  _getPermission() async => await [
    Permission.sms,
  ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  _sendMessage(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;

}
/*
class send_sms_from_the_app extends StatefulWidget {
  const send_sms_from_the_app({Key? key}) : super(key: key);

  @override
  State<send_sms_from_the_app> createState() => _send_sms_from_the_appState();
}

class _send_sms_from_the_appState extends State<send_sms_from_the_app> {

  check() async {
    if (await _isPermissionGranted()) {
    if ((await _supportCustomSim)!)
    _sendMessage("8144663240", "Hello", simSlot: 1);
    else
    _sendMessage("770885522", "Hello");
    } else
    _getPermission();
  }

  _getPermission() async => await [
    Permission.sms,
  ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  _sendMessage(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Send Sms'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () async {
            if (await _isPermissionGranted()) {
              if ((await _supportCustomSim)!)
                _sendMessage("8144663240", "Hello", simSlot: 1);
              else
                _sendMessage("770885522", "Hello");
            } else
              _getPermission();
          },
        ),
      ),
    );
  }
}
*/