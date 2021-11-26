import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'input_field.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  String label;
  String name;
  String type;
  String errorMsg;
  String placeholder;

  TextInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.name,
    this.errorMsg = "",
    this.type = "text",
    this.placeholder = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);

    return Column(
      children: [
        // Password Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label),
        ),
        // Password Input
        Align(
          alignment: Alignment.centerLeft,
          child: InputField(
            controller: controller,
            hintText: placeholder,
            status: errorMsg == "" ? false : true,
            type: type,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorMsg,
              style: smallTextStyle(dangerColor),
            ),
          ),
        ),
        SizedBox(
          height: SizeScalling().setHeight(2),
        ),
      ],
    );
  }
}
