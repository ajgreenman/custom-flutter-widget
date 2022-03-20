import 'package:article/widgets/timeline_node.dart';
import 'package:article/widgets/timeline_pole.dart';
import 'package:flutter/material.dart';

class TimelineNodeWithPole extends StatelessWidget {
  const TimelineNodeWithPole({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineNode(index: index),
        TimelinePole(index: index),
      ],
    );
  }
}
