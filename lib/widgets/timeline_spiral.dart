import 'package:flutter/material.dart';

class TimelineSwirl extends StatelessWidget {
  const TimelineSwirl({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPaint(
        painter: _CurvePainter(index),
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  _CurvePainter(this.index);

  final int index;

  // allows spiral to extend through to next stage
  static const _extraSpiralLength = 32.0;

  static const _spiralRadius = 6.0;

  static const _spiralStrokeWidth = 4.0;
  static const _borderStrokeWidth = 1.0;
  static const _spiralOffset = -1.0;

  @override
  void paint(Canvas canvas, Size size) {
    _drawSpiral(canvas, size);
    _drawOutsideLines(canvas, size);
  }

  void _drawSpiral(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = index % 2 == 0 ? Colors.lightBlue : Colors.lightBlue[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = _spiralStrokeWidth
      ..strokeCap = StrokeCap.round;

    var spiral = Path();
    spiral.moveTo(_spiralRadius, -1.0);

    for (var i = _spiralOffset;
        i < size.height + _extraSpiralLength;
        i += _spiralStrokeWidth) {
      if ((i - (_spiralStrokeWidth + _spiralOffset)) %
              (_spiralStrokeWidth * 2) ==
          0.0) {
        spiral.lineTo(-_spiralRadius, i);
      } else {
        spiral.moveTo(_spiralRadius, i);
      }
    }

    canvas.drawPath(spiral, paint);
  }

  void _drawOutsideLines(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = _borderStrokeWidth
      ..strokeCap = StrokeCap.butt;

    var leftLine = Path();
    leftLine.moveTo(-_spiralRadius, -_borderStrokeWidth);
    leftLine.lineTo(
      -_spiralRadius,
      size.height + (_extraSpiralLength - _spiralStrokeWidth),
    );
    canvas.drawPath(leftLine, paint);

    var rightLine = Path();
    rightLine.moveTo(_spiralRadius, -_borderStrokeWidth);
    rightLine.lineTo(
      _spiralRadius,
      size.height + (_extraSpiralLength - _spiralStrokeWidth),
    );
    canvas.drawPath(rightLine, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
