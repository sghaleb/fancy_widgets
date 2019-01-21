import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final double radius;
  final IconData icon;
  final double elevation;
  final Color splashColor;

  final Function() onPressed;

  RoundIconButton(
      {this.color,
      this.splashColor: const Color(0X4DFFFFFF),
      this.radius,
      this.icon,
      this.backgroundColor,
      @required this.onPressed,
      this.elevation: 0.0});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius * 2),
        ),
      ),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            CustomPaint(
              painter: _CirclePainter(
                radius: radius,
                color: backgroundColor,
              ),
            ),
            Center(
              child: Icon(icon, color: color, size: radius),
            ),
            Material(
              type: MaterialType.circle,
              elevation: 0.0,
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius * 2),
                  ),
                ),
                splashColor: splashColor,
                enableFeedback: true,
                excludeFromSemantics: false,
                onTap: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  double radius;
  Color color;

  _CirclePainter({this.radius: 35.0, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double spacing = radius / 10 + 1;

    // Draw inner circle (filled)
    canvas.drawCircle(
      Offset(radius, radius),
      radius - spacing,
      Paint()
        ..style = PaintingStyle.fill
        ..color = color,
    );

    // Draw outer circle (stroke only)
    canvas.drawCircle(
      Offset(radius, radius),
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = color,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
