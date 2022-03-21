import 'package:article/widgets/timeline_node.dart';
import 'package:article/widgets/timeline_spiral.dart';
import 'package:flutter/material.dart';

class TimelineNodeSpiral extends StatelessWidget {
  const TimelineNodeSpiral({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineNode(index: index),
        TimelineSwirl(index: index),
      ],
    );
  }
}
