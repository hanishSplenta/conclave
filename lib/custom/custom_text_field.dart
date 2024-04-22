import 'package:flutter/material.dart';

import '../constants/constants.dart';

class FederalBankTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType inputType;

  FederalBankTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.inputType,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  State<FederalBankTextField> createState() => _FederalBankTextFieldState();
}

class _FederalBankTextFieldState extends State<FederalBankTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      controller: widget.controller,
      // validator: validator,
      decoration: InputDecoration(
        label: Text(
          widget.labelText,
          style: const TextStyle(
            color: secondaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0x00999999),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8),
        //   borderSide: BorderSide(color: secondaryColor, width: 1),
        // ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: tertiaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
    );
  }
}
