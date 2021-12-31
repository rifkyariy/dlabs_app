import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'input_field.dart';

class TextInput extends StatelessWidget {
  /// Creates variety of text input.
  ///
  /// The [type] default is text.
  /// We can use other type such as date, number, date, password.
  /// non-negative.
  final TextEditingController controller;
  String label;
  String name;
  String type;
  String errorMsg;
  String placeholder;
  DateTime firstDate;
  DateTime lastDate;
  bool isDisabled;

  TextInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.name,
    DateTime? firstDate,
    DateTime? lastDate,
    this.errorMsg = "",
    this.type = "text",
    this.isDisabled = false,
    this.placeholder = "",
  })  : firstDate = firstDate ?? DateTime(1990),
        lastDate = lastDate ?? DateTime(2101);

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);

    return Column(
      children: [
        // Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: mediumTextStyle(blackColor, fontSize: 14),
          ),
        ),
        // Input
        Align(
          alignment: Alignment.centerLeft,
          child: InputField(
            controller: controller,
            hintText: placeholder,
            firstDate: firstDate,
            lastDate: lastDate,
            status: errorMsg == "" ? false : true,
            type: type,
            isDisabled: isDisabled,
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
