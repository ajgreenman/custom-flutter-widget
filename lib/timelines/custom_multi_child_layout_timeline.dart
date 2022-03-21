import 'package:article/main.dart';
import 'package:article/widgets/timeline_node_spiral.dart';
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
                    delegate: TimelineLayoutDelegate(),
                    children: [
                      LayoutId(
                        id: TimelineLayoutChild.leftTimelineNodeSpiral,
                        child: TimelineNodeSpiral(index: index),
                      ),
                      LayoutId(
                        id: TimelineLayoutChild.timelineStageContent,
                        child: timelineStageContent,
                      ),
                      LayoutId(
                        id: TimelineLayoutChild.rightTimelineNodeSpiral,
                        child: TimelineNodeSpiral(index: index),
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
  leftTimelineNodeSpiral,
  rightTimelineNodeSpiral,
}

class TimelineLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // ensure we have all three children
    if (!hasChild(TimelineLayoutChild.leftTimelineNodeSpiral) ||
        !hasChild(TimelineLayoutChild.timelineStageContent) ||
        !hasChild(TimelineLayoutChild.rightTimelineNodeSpiral)) {
      return;
    }

    // first layout the content so we can get its size
    var timelineStageContentSize = layoutChild(
      TimelineLayoutChild.timelineStageContent,
      BoxConstraints.loose(size), // this can be as big as it wants
    );

    // layout the first timelineNodeSpiral with constraints
    var timelineNodeSpiralSize = layoutChild(
      TimelineLayoutChild.leftTimelineNodeSpiral,
      BoxConstraints(
        // can be as wide as it wants
        maxWidth: size.width,
        // can only be as tall as the content
        maxHeight: timelineStageContentSize.height,
      ),
    );

    // layout the other
    layoutChild(
      TimelineLayoutChild.rightTimelineNodeSpiral,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: timelineStageContentSize.height,
      ),
    );

    // the left timelineNodeSpiral gets positioned first
    positionChild(
      TimelineLayoutChild.leftTimelineNodeSpiral,
      Offset.zero,
    );

    // the content is next, and we can calculate an offset using
    // the size of the first timelineNodeSpiral
    positionChild(
      TimelineLayoutChild.timelineStageContent,
      Offset(
        timelineNodeSpiralSize.width + stagePadding,
        0.0,
      ),
    );

    // the final timelineNodeSpiral uses both sizes for its offset
    positionChild(
      TimelineLayoutChild.rightTimelineNodeSpiral,
      Offset(
        timelineNodeSpiralSize.width +
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
