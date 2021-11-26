import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'input_field.dart';
import 'package:dlabs_apps/app/global_widgets/custom_dropdown.dart';

class SelectInput extends StatelessWidget {
  final TextEditingController controller;
  String label;
  String name;
  String type;
  String errorMsg;
  String placeholder;
  List<Map<String, dynamic>> items;

  SelectInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.name,
    this.errorMsg = "",
    this.type = "text",
    this.placeholder = "",
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label),
        ),
        // Select Input
        Align(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 5),
            width: size.width * 0.9,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(4.8),
                border: Border.all(
                    color: errorMsg == "" ? lightGreyColor : dangerColor)),
            child: SelectFormField(
              type: SelectFormFieldType.dropdown,
              initialValue: '0',
              items: items,
              onChanged: (val) => print(val),
              onSaved: (val) => print(val),
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: errorMsg == "" ? lightGreyColor : dangerColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorMsg,
              style: smallTextStyle(dangerColor),
            ),
          ),
        ),
      ],
    );
  }
}
