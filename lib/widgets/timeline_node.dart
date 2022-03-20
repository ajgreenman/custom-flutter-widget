import 'package:article/main.dart';
import 'package:flutter/material.dart';

class TimelineNode extends StatelessWidget {
  const TimelineNode({Key? key, required this.index}) : super(key: key);

  final int index;

  static const dimension = stagePadding * 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index % 2 == 0 ? Colors.lightBlue : Colors.lightBlue[800]!,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/flutter_logo.png',
        ),
      ),
    );
  }
}
