import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  double width = 0;
  HorizontalSpacer({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class VerticalSpacer extends StatelessWidget {
  double height = 0;
  VerticalSpacer({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
