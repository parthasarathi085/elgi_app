// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

void main() {
  runApp(
      MaterialApp(
        scaffoldMessengerKey: snack_bar.messegerKey ,
        home: const main_page(),
      )
  );
}

class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {

  var oad = overall_data() ;
  
  
  //var data_ = overall_data() ;
  
  //var s = (data_.data['Sales Details']!['Order'] as List)[0] ;
  var s = (oad.data['Sales Details']!['Order'] as List) ;
  
  //print(s) ;
  //data_.data['Sales Details']!["$s"] = "How are you!!!" ;
  //print(data_.data['Sales Details']!["$s"]);
  

  

  List<Step> steps_details() => [
    Step(
        title: const Text('Consumer Details'),
        content: Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height - 200 ,//80 * (oad.data["Consumer Details"]?["Count"] as double) - 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: oad.data["Consumer Details"]?["Count"] as int,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        decoration: InputDecoration(
                            icon: const Icon(Icons.account_balance , color: Colors.black,),
                            hintText: "${oad.data['Consumer Details']?['${s[index]}']}" ,
                            labelText: "${oad.data['Consumer Details']?['${(oad.data['Sales Details']!['Order'] as List)[index]}']}",
                            hintStyle: const TextStyle(
                              color: Colors.grey ,
                              fontWeight: FontWeight.bold ,
                            ),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                        onChanged: (value) {
                          if ((oad.data['Consumer Details']?["${(oad.data['Sales Details']!['Order'] as List)[index]}"] as String) == "") {
                            oad.data['Consumer Details']?["${(oad.data['Sales Details']!['Order'] as List)[index]}"] = value ;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //validator: (cname) => cname != null && cname.length < 3 && cname.length > 0 ? 'Enter atleast 3 characters ...': null ,
                        textInputAction: TextInputAction.next,
                      ),
                    ) ,
                    const SizedBox(height : 20) ,
                  ],
                ),
              )
          ),
        )
    ),
    Step(
        title: const Text('Sales Details'),
        content: Container()
    ),
    Step(
        title: const Text('Visit details'),
        content: Container()
    ),
    Step(
        title: const Text('Confirm'),
        content: Center(
          child: Container(),
        )
    )
  ] ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print("${oad.data["Consumer Details"]}") ;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Stepper(
          steps: steps_details(),
          type: StepperType.horizontal,
          currentStep: 0,
          onStepContinue: () {
            print("${oad.data["Consumer Details"]}") ;
            snack_bar.show_snacker_bar("tyt" , 1) ;
          },
          onStepCancel: () {
            snack_bar.show_snacker_bar("tyt" , 0) ;
          }
        ),
      ),
    );
  }
}

class send_sms_from_the_app {

  Future<bool> is_sms_permission_granted() async =>
      await Permission.sms.status.isGranted;

  Future<bool?> get support_custom_Sim async =>
      await BackgroundSms.isSupportCustomSim;

  get_sms_permission() async => await [
    Permission.sms,
  ].request();

  check_and_send(mobile_number) async{
    if (await is_sms_permission_granted() ) {
      if ((await support_custom_Sim)!) {
        send_message("$mobile_number", "Hello", simSlot: 1);
      } else {
        send_message("770885522", "Hello");
      }
    } else {
      get_sms_permission();
    }
  }

  send_message(String phoneNumber, String message, {int? simSlot}) async {
    try {
      await BackgroundSms.sendMessage(phoneNumber: phoneNumber, message: message, simSlot: simSlot);
      snack_bar.show_snacker_bar('Sent email Successfully!!!' , 1) ;
    } on Exception catch (e) {
      snack_bar.show_snacker_bar('oops!!! error occurred while processing your request...\n$e' , 0) ;
    }
  }
}


class send_mail_from_the_app {

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
      ..subject = 'Rating demo'
      ..text = 'hi';

    try{
      await send(message, smtpServer) ;
      snack_bar.show_snacker_bar('Sent email Successfully!!!' , 1) ;
    } on MailerException catch (e) {
      snack_bar.show_snacker_bar('oops!!! error occurred while processing your request...\n$e' , 0) ;
    }
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


class snack_bar {

  static GlobalKey<ScaffoldMessengerState> messegerKey = GlobalKey<ScaffoldMessengerState>() ;

  static show_snacker_bar(String? text, int success_status) {

    if(text == null) return ;

    final snackBar = SnackBar(
      content: Text(text , style: const TextStyle(fontSize: 20),),
      backgroundColor: success_status == 1 ? Colors.green : Colors.red,
    );

    messegerKey.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(snackBar) ;
  }
}


class overall_data {

  var data = {

    /*start - consumer details*/
    "Consumer Details": {
      "Count" : 2 ,
      "Order" : ["Company Name" , "Contact Name"] ,
      "Company Name" : "" ,
      "Contact Name" : "" ,
    } ,
    /*end - consumer details*/

    /*start - sales details*/
    "Sales Details" : {
      "Count" : "5" ,
      "Order" : ["Industry Type" , "Consumer Type" , "Remarks" , "Date of Visit" , "Sales Engineer Name"] ,
      "Industry Type" : "" ,
      "Consumer Type" : "" ,
      "Remarks" : "" ,
      "Date of Visit" : "" ,
      "Sales Engineer Name" : "" ,

      "Industry Type details" : ["Construction" , "Telecommunication" , "Power"] ,

      "Sales Engineer Name details" : ['A' , 'B' , 'C']

    } ,
    /*end - sales details*/

    /*start - visit details*/
    "Visit Details" : {
      "Count" : "2" ,
      "Order" : ["Type of Visit" , "Visit Outcome"] ,
      "Type of Visit" : "" ,
      "Visit Outcome" : "" ,

      "Type of Visit details" : ["Enquiry" , "Courtesy Visit" , "Pending Payment Follow-up"] ,

      "Visit Outcome details" : ["Visited-Customer not met" , "Visited-Courtesy"]
    } ,
    /*end - visit details*/

    /*start - feedback*/
    "Feedback" : {
      "Count" : "2" ,
      "Order" : ["Mobile no" , "Give the Rating"] ,
      "Mobile No" : "" ,
      "Give the Rating" : ""
    }
    /*start - feedback*/

  } ;

}


/*
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
*/

/*
import 'dart:math';
void main() {
  
  
  Random random = Random();
   
  var min = 1234;
  var max = 9876;

  int random_pass_code = min + random.nextInt(max - min);
  print(random_pass_code);
  
  
  var overall_data_class = overall_data() ;
  
  print("${overall_data_class.data['Sales Details']?['Industry Type details'][0]}") ;
  
}
*/
