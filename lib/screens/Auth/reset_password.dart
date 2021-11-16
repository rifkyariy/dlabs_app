// // ignore_for_file: file_names
// import 'package:dlabs_apps/theme.dart';
// import 'package:dlabs_apps/Components/input_field.dart';
// import 'package:dlabs_apps/Components/navbar.dart';
// import 'package:dlabs_apps/Components/button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ResetPassword extends StatelessWidget {
//   TextEditingController oldPassController = TextEditingController(text: '');
//   TextEditingController newPasswordController = TextEditingController(text: '');
//   TextEditingController confirmPasswordController =
//       TextEditingController(text: '');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: whiteColor,
//         body: Container(
//           child: Column(
//             children: [
//               Navbar(),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(top: 24, left: 24.0, right: 24.0),
//                 child: Column(
//                   children: [
//                     // Forgot Password
//                     // Label Old Password
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text('Old Password'),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: InputField(
//                         controller: oldPassController,
//                         hintText: "",
//                         type: 'password',
//                         onChanged: (value) {},
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Please enter your old password.',
//                           style: SmallTextStyle(dangerColor),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text('New Password'),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: InputField(
//                         controller: newPasswordController,
//                         hintText: "",
//                         type: 'password',
//                         onChanged: (value) {},
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Please enter your new password.',
//                           style: SmallTextStyle(dangerColor),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text('Confirm Password'),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: InputField(
//                         controller: confirmPasswordController,
//                         hintText: "",
//                         type: 'password',
//                         onChanged: (value) {},
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Password doesn't match.",
//                           style: SmallTextStyle(dangerColor),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Button(
//                       text: 'Reset Password',
//                       textColor: whiteColor,
//                       onClicked: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/image/bg-overlay-ambulance.png"),
//                 fit: BoxFit.fitWidth,
//                 alignment: Alignment.bottomCenter),
//           ),
//         ));
//   }
// }
