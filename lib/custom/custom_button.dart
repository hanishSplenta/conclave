import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required String text,
    Function()? onTap,
  })  : _onTap = onTap,
        _text = text;

  final Function()? _onTap;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          color: primaryColor,
        ),
        child: Center(
            child: Text(_text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}

class CustomShortButton extends StatelessWidget {
  const CustomShortButton({
    super.key,
    required String text,
    Function()? onTap,
  })  : _onTap = onTap,
        _text = text;

  final Function()? _onTap;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        // width: double.infinity,
        height: 60,
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          color: primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(_text, style: const TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}
