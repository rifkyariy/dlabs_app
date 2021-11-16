// ignore_for_file: file_names
import 'dart:convert';
import 'package:dlabs_apps/providers/auth_provider.dart';
import 'package:intl/intl.dart';
import 'package:dlabs_apps/components/text_input.dart';
import 'package:dlabs_apps/theme.dart';
import 'package:dlabs_apps/Components/input_field.dart';
import 'package:dlabs_apps/Components/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePersonalInfo extends StatefulWidget {
  @override
  State<UpdatePersonalInfo> createState() => _UpdatePersonalInfoState();
}

class _UpdatePersonalInfoState extends State<UpdatePersonalInfo> {
  TextEditingController idNumberController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController dateOfBirthController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  bool isLoading = false;
  String identityNumberError = "";
  String phoneNumberError = "";
  String dateOfBirthError = "";
  String addressError = "";

  String? _genderValue = '0';
  void _changeGender(String value) {
    _genderValue = value;
    setState(() {
      switch (_genderValue) {
        case '0':
          break;

        case '1':
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    getDate() async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(
              2000), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101));

      if (pickedDate != null) {
        print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

        print(
            formattedDate); //formatted date output using intl package =>  2021-03-16
        //you can implement different kind of Date Format here according to your requirement

        setState(() {
          dateOfBirthController.text =
              formattedDate; //set output date to TextField value.
        });
      } else {
        print("Date is not selected");
      }
    }

    handleSignUp() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String email = prefs.getString('email') ?? '';
      String password = prefs.getString('password') ?? '';
      String fullname = prefs.getString('fullname') ?? '';
      String identityNumber = idNumberController.text;
      String phoneNumber = phoneNumberController.text;
      String dateOfBirth = dateOfBirthController.text;
      String address = addressController.text;

      if (identityNumber != "") {
        setState(() {
          identityNumberError = "";
        });

        if (phoneNumber != "") {
          setState(() {
            phoneNumberError = "";
          });

          if (dateOfBirth != "") {
            setState(() {
              dateOfBirthError = "";
            });

            if (address != "") {
              setState(() {
                addressError = "";
                isLoading = true;
              });

              if (await authProvider.register(
                  email: email,
                  password: password,
                  fullname: fullname,
                  identityNumber: identityNumber,
                  phoneNumber: phoneNumber,
                  dateOfBirth: dateOfBirth,
                  gender: _genderValue,
                  address: address)) {
                Navigator.pushNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: dangerColor,
                    content: Text(
                      'Register Failed',
                      textAlign: TextAlign.center,
                      style: subtitleTextStyle(whiteColor),
                    )));
              }

              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                addressError = "Address can't be blank.";
              });
            }
          } else {
            setState(() {
              dateOfBirthError = "Date of birth can't be blank.";
            });
          }
        } else {
          setState(() {
            phoneNumberError = "Please enter a valid phone number.";
          });
        }
      } else {
        setState(() {
          identityNumberError = "Please enter a valid identity number.";
        });
      }

      print('get from shared');
      print(email);
      print(password);
      print(fullname);
      print(_genderValue);
    }

    return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 96.0, left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              children: [
                // Logo and Header
                Center(
                  child: Image.asset(
                    'assets/image/logo-dlab.png',
                    width: 102,
                    height: 43,
                  ),
                ),
                SizedBox(height: 40),

                // Google Login
                Center(
                    child: ElevatedButton.icon(
                  icon: Image.asset(
                    'assets/image/logo-google-48dp.png',
                    width: 20.5,
                    height: 20.5,
                  ),
                  label: Text(
                    'Sign Up with Google',
                    style: subtitleTextStyle(blackColor),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    elevation: 0,
                    minimumSize: Size(double.infinity, 46),
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: lightGreyColor,
                      ),
                      borderRadius: new BorderRadius.circular(4.8),
                    ),
                  ),
                )),
                SizedBox(
                  height: 16,
                ),

                // Divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/image/line-divider.png',
                    ),
                    Text(
                      'or',
                      style: SmallTextStyle(blackColor),
                    ),
                    Image.asset(
                      'assets/image/line-divider.png',
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),

                // Step Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Personal Detail',
                      style: regularTextStyle(primaryColor),
                    ),
                    Text(
                      'Step 2 of 2',
                      style: SmallTextStyle(greyColor),
                    )
                  ],
                ),
                Divider(color: greyColor),
                SizedBox(
                  height: 16,
                ),

                // Identity Number
                TextInput(
                    controller: idNumberController,
                    label: 'Identity Number',
                    type: 'number',
                    errorMsg: identityNumberError,
                    name: 'identity number'),

                // Phone Number
                TextInput(
                    controller: phoneNumberController,
                    label: 'Phone Number',
                    type: 'number',
                    errorMsg: phoneNumberError,
                    name: 'phone number'),

                // Date of Birth
                TextInput(
                    controller: dateOfBirthController,
                    label: 'Date of Birth',
                    type: 'date',
                    errorMsg: dateOfBirthError,
                    name: 'date of birth'),

                // Gender
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Gender'),
                ),
                Row(
                  children: [
                    Radio(
                        value: '0',
                        groupValue: _genderValue,
                        onChanged: (String? value) {
                          setState(() {
                            _genderValue = value;
                          });
                        }),
                    Text('Male'),
                    Radio(
                        value: '1',
                        groupValue: _genderValue,
                        onChanged: (String? value) {
                          setState(() {
                            _genderValue = value;
                          });
                        }),
                    Text('Female'),
                  ],
                ),

                // Address
                TextInput(
                    controller: addressController,
                    label: 'Address',
                    errorMsg: addressError,
                    placeholder: 'e.g. mail@address.com',
                    type: 'textarea',
                    name: 'address'),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
              top: 12, bottom: 24.0, left: 24.0, right: 24.0),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: lightGreyColor, width: 1))),
          child:
              // Submit Button
              Button(
                  text: 'Sign Up',
                  textColor: whiteColor,
                  onClicked: handleSignUp),
        ));
  }
}
