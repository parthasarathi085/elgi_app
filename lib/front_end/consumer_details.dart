import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



Widget consumer_details(BuildContext context) {

  late String cname ;
  late String cnname;
  late String address ;
  late String pinno;
  /*
  late String countryValue = "";
  late String? stateValue = "";
  late String? cityValue = "";
  */

  //late String dob = " ";


  final formKey = GlobalKey<FormState>() ;


  final cnameController = TextEditingController() ;
  final cnnameController = TextEditingController() ;
  final addressController = TextEditingController() ;
  final pinnoController = TextEditingController() ;
  //final dobController = TextEditingController() ;

  @override
  void dispose() {

    cnameController.dispose() ;
    cnnameController.dispose() ;
    addressController.dispose() ;
    pinnoController.dispose();
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
          const SizedBox(height : 20) ,
          TextFormField(
            controller: cnameController,
            decoration: InputDecoration(
              icon: Icon(Icons.account_balance , color: Colors.black,),
              hintText: 'Company Name',
              labelText: 'Company Name',
              hintStyle: TextStyle(
                color: Colors.grey ,
                fontWeight: FontWeight.bold ,
              ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => cname = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (cname) => cname != null && cname.length < 3 && cname.length > 0 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height : 20) ,
          TextFormField(
            controller: cnameController,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle , color: Colors.black,),
                hintText: 'Contact Name',
                labelText: 'Contact Name',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => cnname = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (cnname) => cnname != null && cnname.length < 3 && cnname.length > 0 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height : 20) ,
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
                icon: Icon(Icons.add_business , color : Colors.black),
                hintText: 'Address',
                labelText: 'Address',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold,
                ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            //obscureText: true,
            onChanged: (val) => address = val ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (address) => address != null && address.length < 1 && address.length > 0 ? 'Enter atleast 1 characters...' : null ,
              textInputAction: TextInputAction.next,
              minLines: 2,
              maxLines: 4,
              //textInputAction: TextInputAction.done
          ) ,
/*
          CSCPicker(
            showStates: true,
            showCities: true,

            flagState: CountryFlag.DISABLE,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border:
                Border.all(color: Colors.grey.shade300, width: 1)),
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
                border:
                Border.all(color: Colors.grey.shade300, width: 1)),
            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Country",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            ///labels for dropdown
            countryDropdownLabel: "*Country",
            stateDropdownLabel: "*State",
            cityDropdownLabel: "*City",

            ///Default Country
            //defaultCountry: DefaultCountry.India,

            ///Disable country dropdown (Note: use it with default country)
            //disableCountry: true,

            ///selected item style [OPTIONAL PARAMETER]
            selectedItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            dropdownHeadingStyle: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold),

            ///DropdownDialog Item style [OPTIONAL PARAMETER]
            dropdownItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 10.0,
            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 10.0,

            ///triggers once country selected in dropdown
            onCountryChanged: (value) {
              setState(() {
                ///store value in country variable
                countryValue = value;
              });
            },

            ///triggers once state selected in dropdown
            onStateChanged: (value) {
              setState(() {
                ///store value in state variable
                stateValue = value;
              });
            },

            ///triggers once city selected in dropdown
            onCityChanged: (value) {
              setState(() {
                ///store value in city variable
                cityValue = value;
              });
            },
          ),

 */
/*
          const SizedBox(height : 20) ,
          TextFormField(
            readOnly: true,
            onTap: () async {
              // Below line stops keyboard from appearing
              FocusScope.of(context).requestFocus(new FocusNode());


              DateTime? Picked_dob = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), //get today's date
                  firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime.now()
              );

              if(Picked_dob != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(Picked_dob);
                dobController.text = formattedDate;
                dob = formattedDate ;
              }

            },
            controller: dobController,
            decoration: InputDecoration(
                icon: Icon(Icons.date_range , color : Colors.black),
                hintText: 'DOB',
                labelText: 'DOB',
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
            onChanged: (dob) => dob = dob ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (dob) => dob != null && dob != dob ? '' : null ,
            textInputAction: TextInputAction.next,
          ) ,
          */
          const SizedBox(height : 20) ,
          TextFormField(
            controller: pinnoController,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle , color: Colors.black,),
                hintText: 'Pincode',
                labelText: 'Pincode',
                hintStyle: TextStyle(
                  color: Colors.grey ,
                  fontWeight: FontWeight.bold ,
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onChanged: (val) => pinno = val,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (pinno) => pinno != null && pinno.length < 7 && pinno.length > 6 ? 'Enter atleast 3 characters ...': null ,
            textInputAction: TextInputAction.next,
          ),

        ],
      ),
    ),
  ) ;
}




