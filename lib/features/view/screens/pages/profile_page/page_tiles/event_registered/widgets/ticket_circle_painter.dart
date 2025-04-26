
import 'package:flutter/material.dart';
import 'package:travelgo_user/core/constants/colors.dart';

class TicketCirclePainter extends CustomPainter {
  final bool isRight;
  TicketCirclePainter({
    super.repaint,
    required this.isRight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint =
        Paint()
          ..color = themeColor
          ..style = PaintingStyle.fill;

    final Paint borderPaint =
        Paint()
          ..color =  themeColor 
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
            -1.5 * 3.1416, // Start angle (top)
            3.1416, // Sweep angle (half circle)
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
            1.5 * 3.1416, // Start angle (top)
            3.1416, // Sweep angle (half circle)
            false,
          );
      final Path fillPath =
          Path()
            ..moveTo(0, 0)
            ..addPath(arcPath, Offset.zero)
            ..lineTo(0, size.height)
            ..close();
      canvas.drawPath(fillPath, fillPaint);
      canvas.drawPath(arcPath, borderPaint); // Optional border
    }
    // Fill the arc (create a closed shape manually if needed)
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
