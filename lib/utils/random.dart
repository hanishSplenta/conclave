import 'package:flutter/material.dart';

class TranslucentContainerWithEllipse extends StatelessWidget {
  final double width;
  final double height;
  final Color
      containerColor; // Adjust for desired translucency (e.g., Colors.black.withOpacity(0.2))

  const TranslucentContainerWithEllipse({
    super.key,
    required this.width,
    required this.height,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(height / 2), // Ellipse shape
      ),
      child: CustomPaint(
        size: Size(width, height),
        painter: TransparentEllipsePainter(),
      ),
    );
  }
}

class TransparentEllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.transparent;
    final path = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TransparentEllipsePainter oldDelegate) => false;
}

class Random {
  void showAutoDismissingPopup(BuildContext context, Widget wid) {
    Future.delayed(const Duration(seconds: 2), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: wid,
          );
        });
  }
}
