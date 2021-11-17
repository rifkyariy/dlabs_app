// ignore_for_file: file_names
import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/input_field_container.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  String type;
  bool status;

  InputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.type,
      this.icon = Icons.person,
      required this.status})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool visibility = false;

  void _toggle() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputFieldContainer(
      status: widget.status,
      child: TextFormField(
        obscureText: widget.type == 'password' ? !visibility : visibility,
        enableSuggestions: false,
        readOnly: widget.type == 'date' ? true : false,
        minLines: widget.type == 'textarea' ? 4 : 1,
        maxLines: widget.type == 'textarea' ? null : 1,
        onTap: widget.type == 'date'
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        1900), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    widget.controller.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              }
            : null,
        controller: widget.controller,
        inputFormatters: widget.type == 'number'
            ? [LengthLimitingTextInputFormatter(16)]
            : [],
        keyboardType: widget.type == 'textarea'
            ? TextInputType.multiline
            : (widget.type == 'number'
                ? TextInputType.number
                : (widget.type == 'email'
                    ? TextInputType.datetime
                    : TextInputType.emailAddress)),
        autocorrect: false,
        cursorColor: blackColor,
        decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
            suffixIcon: widget.type == 'password'
                ? IconButton(
                    icon: Icon(
                      visibility ? Icons.visibility : Icons.visibility_off,
                    ),
                    color: Color(0xff000000),
                    onPressed: () {
                      _toggle();
                    })
                : (widget.type == 'date'
                    ? IconButton(
                        icon: Icon(Icons.calendar_today),
                        color: Color(0xff000000),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              widget.controller.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      )
                    : null)),
      ),
    );
  }
}
