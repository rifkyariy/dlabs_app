import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
    required this.hintText,
    this.prefixIcon,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String) onSubmitted;
  final String hintText;
  final Widget? prefixIcon;
  final VoidCallback onClear;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide.none,
  );

  bool isEmpty = true;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {
        isEmpty = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
        // hintStyle: AppTextStyles.of(context)?.body3.copyWith(
        //       color: context.colors.lightColor,
        //     ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        fillColor: Colors.white,
        isDense: true,
        filled: true,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 14,
        ),
        suffixIcon: isEmpty
            ? null
            : Padding(
                padding: EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    widget.controller.clear();
                    widget.onClear();
                  },
                  child: Icon(
                    Icons.close_outlined,
                    // color: context.colors.lightColor,
                  ),
                ),
              ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 36,
        ),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      // style: AppTextStyles.of(context)?.body3.copyWith(
      //       color: context.colors.lightColor,
      //     ),
    );
  }
}
