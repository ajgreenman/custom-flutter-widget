import 'package:article/main.dart';
import 'package:article/widgets/timeline_node_with_pole.dart';
import 'package:article/widgets/timeline_stage_content.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Warning! This won't work because we need to set our parent's size
class CustomMultiChildLayoutTimeline extends StatelessWidget {
  const CustomMultiChildLayoutTimeline({Key? key, required this.stages})
      : super(key: key);

  final List<TimelineStageContent> stages;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 500,
      child: Column(
        children: [
          ...stages
              .mapIndexed(
                (index, timelineStageContent) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMultiChildLayout(
                    delegate: _TimelineLayoutDelegate(),
                    children: [
                      LayoutId(
                        id: TimelineLayoutChild.leftTimelineNodeWithPole,
                        child: TimelineNodeWithPole(index: index),
                      ),
                      LayoutId(
                        id: TimelineLayoutChild.timelineStageContent,
                        child: timelineStageContent,
                      ),
                      LayoutId(
                        id: TimelineLayoutChild.rightTimelineNodeWithPole,
                        child: TimelineNodeWithPole(index: index),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

enum TimelineLayoutChild {
  timelineStageContent,
  leftTimelineNodeWithPole,
  rightTimelineNodeWithPole,
}

class _TimelineLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // ensure we have all three children
    if (!hasChild(TimelineLayoutChild.leftTimelineNodeWithPole) ||
        !hasChild(TimelineLayoutChild.timelineStageContent) ||
        !hasChild(TimelineLayoutChild.rightTimelineNodeWithPole)) {
      return;
    }

    // first layout the content so we can get its size
    var timelineStageContentSize = layoutChild(
      TimelineLayoutChild.timelineStageContent,
      BoxConstraints.loose(size), // this can be as big as it wants
    );

    // layout the first timelineNodeWithPole with constraints
    var timelineNodeWithPoleSize = layoutChild(
      TimelineLayoutChild.leftTimelineNodeWithPole,
      BoxConstraints(
        // can be as wide as it wants
        maxWidth: size.width,
        // can only be as tall as the content
        maxHeight: timelineStageContentSize.height,
      ),
    );

    // layout the other
    layoutChild(
      TimelineLayoutChild.rightTimelineNodeWithPole,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: timelineStageContentSize.height,
      ),
    );

    // the left timelineNodeWithPole gets positioned first
    positionChild(
      TimelineLayoutChild.leftTimelineNodeWithPole,
      Offset.zero,
    );

    // the content is next, and we can calculate an offset using
    // the size of the first timelineNodeWithPole
    positionChild(
      TimelineLayoutChild.timelineStageContent,
      Offset(
        timelineNodeWithPoleSize.width + stagePadding,
        0.0,
      ),
    );

    // the final timelineNodeWithPole uses both sizes for its offset
    positionChild(
      TimelineLayoutChild.rightTimelineNodeWithPole,
      Offset(
        timelineNodeWithPoleSize.width +
            stagePadding +
            timelineStageContentSize.width +
            stagePadding,
        0.0,
      ),
    );

    // but wait, this doesn't work! We need MultiChildRenderObjectWidget
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
