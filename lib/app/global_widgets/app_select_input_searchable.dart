import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchableSelectInput extends StatefulWidget {
  String label, name, errorMsg;
  String selectedItem;
  List<Map<String, dynamic>>? items;
  void Function(String?)? onChanged;
  bool isDisabled;

  SearchableSelectInput({
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
  State<SearchableSelectInput> createState() => _SearchableSelectInputState();
}

class _SearchableSelectInputState extends State<SearchableSelectInput> {
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
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(4.8),
              border: Border.all(
                  width: 1.5,
                  color: widget.errorMsg == "" ? lightGreyColor : dangerColor),
            ),
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSearchBox: true,
              showSelectedItems: true,
              dropdownSearchDecoration: InputDecoration(
                filled: widget.isDisabled,
                fillColor: lightGreyColor,
                focusColor: greenSuccessColor,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 5),
              ),
              items: widget.items!.map((Map item) {
                return '${item['value']}';
              }).toList(),
              enabled: !widget.isDisabled,
              selectedItem: widget.selectedItem,
              onChanged: !widget.isDisabled
                  ? (String? selected) {
                      // final selectedId = widget.items!
                      //     .where((item) => item['value'] == selected)
                      //     .toList();

                      // setState(() {
                      //   widget.selectedItem.text = selectedId.first['id'];
                      // });
                      setState(() {
                        widget.selectedItem = selected!;
                      });
                    }
                  : null,
            ),

            // DropdownButton<String>(
            //   underline: const SizedBox(),
            //   isExpanded: true,
            //   value: widget.selectedItem.text,
            //   items: widget.items!.map((Map item) {
            //     return DropdownMenuItem<String>(
            //       value: item['id'],
            //       child: Text(item['value']),
            //     );
            //   }).toList(),
            //   onChanged: !widget.isDisabled
            //       ? (String? selected) {
            //           print(widget.selectedItem);
            //           setState(() {
            //             widget.selectedItem.text = selected!;
            //           });
            //         }
            //       : null,
            // ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
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
