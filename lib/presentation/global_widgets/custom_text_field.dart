import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, required this.label, this.onChanged, this.hintText})
      : super(key: key);

  final String label;

  final String? hintText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      onChanged: onChanged,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.black),
        label: Text(
          label,
        ),
        // labelStyle: Theme.of(context)
        //     .inputDecorationTheme
        //     .labelStyle
        //     ?.copyWith(color: Colors.black),
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.5),
        ),
      ),
    );
  }
}
