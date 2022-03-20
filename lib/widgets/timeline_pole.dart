import 'package:flutter/material.dart';

class TimelinePole extends StatelessWidget {
  const TimelinePole({Key? key, required this.index}) : super(key: key);

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

  // allows pole to extend through to next stage
  static const _extraPoleLength = 32.0;

  static const _poleRadius = 6.0;

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
    spiral.moveTo(_poleRadius, -1.0);

    for (var i = _spiralOffset;
        i < size.height + _extraPoleLength;
        i += _spiralStrokeWidth) {
      if ((i - (_spiralStrokeWidth + _spiralOffset)) %
              (_spiralStrokeWidth * 2) ==
          0.0) {
        spiral.lineTo(-_poleRadius, i);
      } else {
        spiral.moveTo(_poleRadius, i);
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
    leftLine.moveTo(-_poleRadius, -_borderStrokeWidth);
    leftLine.lineTo(
      -_poleRadius,
      size.height + (_extraPoleLength - _spiralStrokeWidth),
    );
    canvas.drawPath(leftLine, paint);

    var rightLine = Path();
    rightLine.moveTo(_poleRadius, -_borderStrokeWidth);
    rightLine.lineTo(
      _poleRadius,
      size.height + (_extraPoleLength - _spiralStrokeWidth),
    );
    canvas.drawPath(rightLine, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
