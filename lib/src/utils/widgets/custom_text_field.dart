import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.label,
    // required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
