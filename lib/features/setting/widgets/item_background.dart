import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ItemBackground extends StatelessWidget {
  final Color color;
  final String background;
  final String backgroundSelected;

  const ItemBackground({
    super.key,
    required this.color,
    required this.background,
    required this.backgroundSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        background == 'System mode'
            ? Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: backgroundSelected == background
                      ? Border.all(
                          color: AppColors.selectedColor,
                          width: 3,
                        )
                      : null,
                ),
                child: CustomPaint(
                  painter: SystemModePainter(),
                ),
              )
            : Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  border: backgroundSelected == background
                      ? Border.all(
                          color: AppColors.selectedColor,
                          width: 3,
                        )
                      : null,
                ),
              ),
        const SizedBox(height: 5),
        Text(background, style: AppStyles.regular),
      ],
    );
  }
}

class SystemModePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;

    final path = getTrianglePath(size.width, size.height);

    canvas.drawPath(
      path,
      paint,
    );
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
