import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

import '../back_end/send_email_from_the_app.dart';

Widget Visit_page(BuildContext context) {
  late String tov;
  late String visitout;
  //late String sendmail;

  final formKey = GlobalKey<FormState>();

  final tovController = TextEditingController();
  final visitoutController = TextEditingController();
  //final sendmailController = TextEditingController();


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
      ..subject = 'Rating demo'
      ..text = 'hi';

    try{
      await send(message, smtpServer) ;
      show_snacker_bar('Sent email Successfully!!!') ;
    } on MailerException catch (e) {
      show_snacker_bar('oops!!! error occurred while processing your request...\n$e') ;
      print(e) ;
    }
  }

  @override
  void dispose() {
    tovController.dispose();
    visitoutController.dispose();
    //sendmailController.dispose();

    dispose();
  }
  return Container(
    //height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height : 20) ,
          DropdownButtonFormField<String>(
            items: <String>['Enquiry','Courtesy Visits','Pending Payment Follow-up','Cold Calls','Re-Engagement'].map((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged:(_){},
            icon: const Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.blue,
            ),
            //dropdownColor: Colors.purple,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle , color: Colors.black,),
                hintText: 'Type of Visit',
                labelText: 'Type of Visit',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),

          ),
          const SizedBox(height : 20) ,
          DropdownButtonFormField<String>(
            items: <String>['Visited-Customer not met','Visited-Courtesy','Visited-Payment Collection/Payment Follow up','Visited-Positive Conservation-Potential Demand Identified','Visited-Negotiation','Visited-No Current Demand'].map((String value){
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged:(_){},
            icon: const Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.blue,
            ),
            //dropdownColor: Colors.purple,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle , color: Colors.black,),
                hintText: 'Visit Outcome',
                labelText: 'Visit Outcome',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),

          ),

          /*TextFormField(
            controller: tovController,
            decoration: InputDecoration(
                icon: Icon(Icons.add_business_outlined , color: Colors.black,),
                hintText: 'Type of Visit',
                labelText: 'Type of Visit',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => tov = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (tov) => tov != null && tov.length < 3 && tov.length > 0 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height : 20) ,
          TextFormField(
            controller: visitoutController,
            decoration: InputDecoration(
                icon: Icon(Icons.add_business_rounded, color: Colors.black,),
                hintText: 'Visit Outcome',
                labelText: 'Visit Outcome',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => visitout = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (visitout) =>visitout != null && visitout.length < 3 && visitout.length > 0 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),*/
          SizedBox(height: 20,),
          InkWell(
            onTap: () => send_email() ,
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Center(
                child: Text(
                    "Send Email",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )

      ],
      ),
    ),
  ) ;
}

