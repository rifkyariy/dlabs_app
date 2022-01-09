import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  String label, name, errorMsg;
  TextEditingController selectedItem;
  List<Map<String, dynamic>>? items;
  void Function(String?)? onChanged;
  bool isDisabled;

  SelectInput({
    Key? key,
    required this.label,
    required this.name,
    this.errorMsg = "",
    this.onChanged,
    this.isDisabled = false,
    required this.selectedItem,
    required this.items,
  }) : super(key: key);

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        // Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: mediumTextStyle(blackColor, fontSize: 14),
          ),
        ),
        // Select Input
        Align(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            width: size.width * 0.9,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(4.8),
                border: Border.all(
                    color:
                        widget.errorMsg == "" ? lightGreyColor : dangerColor)),
            child: DropdownButton<String>(
              underline: const SizedBox(),
              isExpanded: true,
              value: widget.selectedItem.text,
              items: widget.items!.map((Map item) {
                return DropdownMenuItem<String>(
                  value: item['id'],
                  child: Text(item['value']),
                );
              }).toList(),
              onChanged: !widget.isDisabled
                  ? (String? selected) {
                      print(widget.selectedItem);
                      setState(() {
                        widget.selectedItem.text = selected!;
                      });
                    }
                  : null,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          // child: Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     widget.errorMsg,
          //     style: smallTextStyle(dangerColor),
          //   ),
          // ),
        ),
      ],
    );
  }
}
