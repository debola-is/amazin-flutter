import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType inputType;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //We would be using a text form field widget so as to
    // be able to perform certain input validation.
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
