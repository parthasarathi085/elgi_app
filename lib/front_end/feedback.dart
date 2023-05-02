import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget Sales_details(BuildContext context) {

  late String industype ;
  late String customtype;
  late String remarks;
  late String visitdate;
  late String sename;
  /*
  late String countryValue = "";
  late String? stateValue = "";
  late String? cityValue = "";
  */

  //late String dob = " ";


  final formKey = GlobalKey<FormState>() ;


  final industypeController = TextEditingController() ;
  final customtypeController = TextEditingController() ;
  final remarksController = TextEditingController() ;
  final visitdateController = TextEditingController() ;
  final senameController = TextEditingController() ;
  //final dobController = TextEditingController() ;
  final customerlist =["ABC", "DEF", "GHI", "JKL"];
  String? selectedval = "";

  @override
  void dispose() {

    industypeController.dispose() ;
    customtypeController.dispose() ;
    remarksController.dispose() ;
    visitdateController.dispose();
    senameController.dispose();
    //dobController.dispose() ;


    // TODO: implement dispose
    dispose();
  }


  return Container(
    //height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         /* const SizedBox(height : 20) ,
          TextFormField(
            controller: industypeController,
            decoration: InputDecoration(
                icon: Icon(Icons.add_business_outlined , color: Colors.black,),
                hintText: 'Industry Type',
                labelText: 'Industry Type',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => industype = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (industype) => industype != null && industype.length < 3 && industype.length > 0 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),textfield*/
          const SizedBox(height : 20) ,
          DropdownButtonFormField<String>(
            items: <String>['Construction','Telecommunication','Power','WW OEM Domestic Customer','WW OE-Indirect Export','Mining','Gunneting,shot and'].map((String value){
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
                hintText: 'Industry Type',
                labelText: 'Idustry Type',
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
          TextFormField(
            controller: customtypeController,
            decoration: InputDecoration(
                icon: Icon(Icons.add_business_rounded, color: Colors.black,),
                hintText: 'Customer Type',
                labelText: 'Customer Type',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => customtype = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (customtype) =>customtype != null && customtype.length < 3 && customtype.length > 0 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height : 20) ,
          TextFormField(
            controller: remarksController,
            decoration: InputDecoration(
                icon: Icon(Icons.add_chart , color : Colors.black),
                hintText: 'Remarks',
                labelText: 'Remarks',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            //obscureText: true,
            onChanged: (val) => remarks = val ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (remarks) => remarks != null && remarks.length < 1 && remarks.length > 0 ? 'Enter atleast 1 characters...' : null ,
            textInputAction: TextInputAction.next,
            minLines: 2,
            maxLines: 4,
            //textInputAction: TextInputAction.done
          ) ,

          const SizedBox(height : 20) ,
          TextFormField(
            readOnly: true,
            onTap: () async {
              // Below line stops keyboard from appearing
              FocusScope.of(context).requestFocus(new FocusNode());


              DateTime? picked_visitdate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), //get today's date
                  firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now()
              );

              if(picked_visitdate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(picked_visitdate);
                visitdateController.text = formattedDate;
                visitdate = formattedDate ;
              }

            },
            controller: visitdateController,
            decoration: InputDecoration(
                icon: Icon(Icons.date_range , color : Colors.black),
                hintText: 'Date of Visit',
                labelText: 'Date of Visit',
              border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            //obscureText: true,
            onChanged: (visitdate) =>visitdate = visitdate ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (visitdate) => visitdate != null && visitdate != visitdate ? '' : null ,
            textInputAction: TextInputAction.next,
          ) ,

        /*  const SizedBox(height : 20) ,
          TextFormField(
            controller: senameController,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle , color: Colors.black,),
                hintText: 'Sales Engineer Name',
                labelText: 'Sales Engineer Name',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => sename = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (sename) => sename != null && sename.length < 7 && sename.length > 6 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),*/
          const SizedBox(height : 20) ,
          DropdownButtonFormField<String>(
            items: <String>['A','B','C','D'].map((String value){
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
                hintText: 'Sales Engineer Name',
                labelText: 'Sales Engineer Name',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),

          )



        ],
      ),
    ),
  ) ;
}




