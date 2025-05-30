
import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class HalfCirclePainter extends CustomPainter {
  final bool isSelected;
  final bool isRight;
  HalfCirclePainter({
    super.repaint,
    required this.isRight,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint =
        Paint()
          ..color = white
          ..style = PaintingStyle.fill;

    final Paint borderPaint =
        Paint()
          ..color = isSelected ? themeColor : grey20
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;
    final Rect arcRect = Rect.fromLTWH(
      -size.width,
      0,
      size.width * 2,
      size.height,
    );
    if (isRight) {
      final Path arcPath =
          Path()..arcTo(
            arcRect,
            -1.5 * 3.1416,
            3.1416, 
            false,
          );
      final Path fillPath =
          Path()
            ..moveTo(0, 0)
            ..addPath(arcPath, Offset.zero)
            ..lineTo(0, size.height)
            ..close();
      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(arcPath, borderPaint);
    } else {
      final Path arcPath =
          Path()..arcTo(
            arcRect,
            1.5 * 3.1416, 
            3.1416, 
            false,
          );
      final Path fillPath =
          Path()
            ..moveTo(0, 0)
            ..addPath(arcPath, Offset.zero)
            ..lineTo(0, size.height)
            ..close();
      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(arcPath, borderPaint); 
    }
  
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
