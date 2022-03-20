import 'package:article/main.dart';
import 'package:article/widgets/timeline_node_with_pole.dart';
import 'package:article/widgets/timeline_stage_content.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class IntrinsicHeightTimeline extends StatelessWidget {
  const IntrinsicHeightTimeline({Key? key, required this.stages})
      : super(key: key);

  final List<TimelineStageContent> stages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...stages
            .mapIndexed(
              (index, timelineStageContent) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TimelineNodeWithPole(index: index),
                      const SizedBox(width: stagePadding),
                      Expanded(child: timelineStageContent),
                      const SizedBox(width: stagePadding),
                      TimelineNodeWithPole(index: index),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
