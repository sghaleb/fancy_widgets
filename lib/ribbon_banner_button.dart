import 'package:flutter/material.dart';

const double kSIDE_TOP_PERC = 0.3;
const double kSIDE_WIDTH_PERC = 0.1;
const double kOVERLAP_PERC = 0.5;
const double kTRIM_PERC = 0.6;

class RibbonBannerButton extends StatelessWidget {
  final Color color;
  final double elevation;
  final double width;
  final double height;
  final Widget text;
  final Color splashColor;

  final Function() onPressed;

  RibbonBannerButton(
      {@required this.text,
      this.width: double.infinity,
      this.height: double.infinity,
      @required this.color,
      this.splashColor: const Color(0X4DFFFFFF),
      this.elevation: 0.0,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double sideWidth = width * kSIDE_WIDTH_PERC;
    double overlap = sideWidth * kOVERLAP_PERC;

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Material(
            shape: _RibbonShapeBorder(),
            elevation: elevation,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.transparent),
              child: CustomPaint(
                painter: _RibbonPainter(color: color),
              ),
            ),
          ),
          Positioned(
            child: Center(child: text),
            top: 0.0,
            left: sideWidth,
            width: width - (sideWidth * 2),
            height: height - overlap,
          ),
          Material(
            shape: _RibbonShapeBorder(),
            color: Colors.transparent,
            elevation: 0.0,
            child: InkWell(
              enableFeedback: true,
              customBorder: _RibbonShapeBorder(),
              splashColor: splashColor,
              onTap: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _RibbonShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(0);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    double sideTop = rect.height * kSIDE_TOP_PERC;
    double sideWidth = rect.width * kSIDE_WIDTH_PERC;
    double overlap = sideWidth * kOVERLAP_PERC;
    double trimSize = sideWidth * kTRIM_PERC;

    Path leftSide = Path()
      ..moveTo(0, sideTop)
      ..lineTo(sideWidth, sideTop)
      ..lineTo(sideWidth, rect.height)
      ..lineTo(0, rect.height)
      ..lineTo(trimSize, (rect.height / 2) + sideTop / 2)
      ..close();

    Path leftClip = Path()
      ..moveTo(sideWidth, rect.height - overlap)
      ..lineTo(sideWidth, rect.height)
      ..lineTo(sideWidth + overlap, rect.height - overlap)
      ..close();

    Path rightClip = Path()
      ..moveTo(rect.width - sideWidth, rect.height - overlap)
      ..lineTo(rect.width - sideWidth - overlap, rect.height - overlap)
      ..lineTo(rect.width - sideWidth, rect.height)
      ..close();

    Path rightSide = Path()
      ..moveTo(rect.width, sideTop)
      ..lineTo(rect.width - trimSize, (rect.height / 2) + sideTop / 2)
      ..lineTo(rect.width, rect.height)
      ..lineTo(rect.width - sideWidth, rect.height)
      ..lineTo(rect.width - sideWidth, sideTop)
      ..close();

    Path mainArea = Path()
      ..addRect(Rect.fromLTWH(
          sideWidth, 0, rect.width - (sideWidth * 2), rect.height - overlap))
      ..close();

    Path path = Path.combine(PathOperation.union, leftSide, mainArea);
    path = Path.combine(PathOperation.union, path, rightSide);
    path = Path.combine(PathOperation.union, path, leftClip);
    path = Path.combine(PathOperation.union, path, rightClip);

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getInnerPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // canvas.drawPath(
    //     getInnerPath(rect),
    //     Paint()
    //       ..strokeWidth = 1
    //       ..style = PaintingStyle.stroke
    //       ..color = Colors.black);
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}

class _RibbonPainter extends CustomPainter {
  Color color;

  _RibbonPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double sideTop = size.height * kSIDE_TOP_PERC;
    double sideWidth = size.width * kSIDE_WIDTH_PERC;
    double overlap = sideWidth * kOVERLAP_PERC;
    double trimSize = sideWidth * kTRIM_PERC;

    Paint mainAreaPaint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    Paint sidesPaint = Paint()
      ..color = color.withAlpha(225)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    Paint shadowPaint = Paint()
      ..color = color.withAlpha(125)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    Path leftSide = Path()
      ..moveTo(0, sideTop)
      ..lineTo(sideWidth, sideTop)
      ..lineTo(sideWidth, size.height)
      ..lineTo(0, size.height)
      ..lineTo(trimSize, (size.height / 2) + sideTop / 2)
      ..close();

    Path leftClip = Path()
      ..moveTo(sideWidth, size.height - overlap)
      ..lineTo(sideWidth, size.height)
      ..lineTo(sideWidth + overlap, size.height - overlap)
      ..close();

    Path rightClip = Path()
      ..moveTo(size.width - sideWidth, size.height - overlap)
      ..lineTo(size.width - sideWidth - overlap, size.height - overlap)
      ..lineTo(size.width - sideWidth, size.height)
      ..close();

    Path rightSide = Path()
      ..moveTo(size.width, sideTop)
      ..lineTo(size.width - trimSize, (size.height / 2) + sideTop / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - sideWidth, size.height)
      ..lineTo(size.width - sideWidth, sideTop)
      ..close();

    Path mainArea = Path()
      ..addRect(Rect.fromLTWH(
          sideWidth, 0, size.width - (sideWidth * 2), size.height - overlap))
      ..close();

    canvas.drawPath(leftSide, sidesPaint);
    canvas.drawPath(mainArea, mainAreaPaint);
    canvas.drawPath(rightSide, sidesPaint);
    canvas.drawPath(leftClip, shadowPaint);
    canvas.drawPath(rightClip, shadowPaint);

    canvas.save();
    canvas.save();
    canvas.save();
    canvas.save();

    canvas.clipPath(leftSide);
    canvas.drawColor(color.withAlpha(225), BlendMode.src);

    canvas.restore();
    canvas.clipPath(rightSide);
    canvas.drawColor(color.withAlpha(225), BlendMode.src);

    canvas.restore();
    canvas.clipPath(leftClip);
    canvas.drawColor(color.withAlpha(125), BlendMode.src);

    canvas.restore();
    canvas.clipPath(rightClip);
    canvas.drawColor(color.withAlpha(125), BlendMode.src);

    canvas.restore();
    canvas.clipPath(mainArea);
    canvas.drawColor(color, BlendMode.src);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
