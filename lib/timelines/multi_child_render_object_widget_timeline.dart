import 'package:article/main.dart';
import 'package:article/widgets/timeline_node.dart';
import 'package:article/widgets/timeline_node_spiral.dart';
import 'package:article/widgets/timeline_stage_content.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MultiChildRenderObjectWidgetTimeline extends StatelessWidget {
  const MultiChildRenderObjectWidgetTimeline({Key? key, required this.stages})
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
                child: TimelineRow(
                  index: index,
                  timelineStageContent: timelineStageContent,
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}

class TimelineRow extends MultiChildRenderObjectWidget {
  TimelineRow({
    Key? key,
    required int index,
    required TimelineStageContent timelineStageContent,
  }) : super(
          key: key,
          children: [
            TimelineNodeSpiral(index: index),
            timelineStageContent,
            TimelineNodeSpiral(index: index),
          ],
        );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return TimelineRowRenderObject();
  }
}

class TimelineRowRenderObject extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, TimelineRowParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TimelineRowParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    // set each child's parent data to TimelineRowParentData
    child.parentData = TimelineRowParentData();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // paint the children in default order (left to right)
    defaultPaint(context, offset);
  }

  @override
  void performLayout() {
    // get our children, and if any are null, don't layout anything
    var leftTimelineNodeSpiral = firstChild;
    if (leftTimelineNodeSpiral == null) {
      size = constraints.smallest;
      return;
    }
    // use childAfter to get successive children
    var timelineStageContent = childAfter(leftTimelineNodeSpiral);
    if (timelineStageContent == null) {
      size = constraints.smallest;
      return;
    }
    var rightTimelineNodeSpiral = childAfter(timelineStageContent);
    if (rightTimelineNodeSpiral == null) {
      size = constraints.smallest;
      return;
    }

    // layout the stage so we can use its height
    timelineStageContent.layout(
      constraints.copyWith(
        minWidth: 0.0,
        maxWidth: constraints.maxWidth -
            TimelineNode.dimension * 2 -
            stagePadding * 2,
      ),
      parentUsesSize: true,
    );

    // layout each timelineNodeSpiral, constraining  height to that of the content
    leftTimelineNodeSpiral.layout(
      BoxConstraints.loose(
        Size(
          constraints.maxWidth,
          timelineStageContent.size.height,
        ),
      ),
      parentUsesSize: true,
    );
    rightTimelineNodeSpiral.layout(
      BoxConstraints.loose(
        Size(
          constraints.maxWidth,
          timelineStageContent.size.height,
        ),
      ),
      parentUsesSize: true,
    );

    // by default the leftTimelineNodeSpiral is aligned to (0,0)
    // so we don't need to modify its position

    // position the stage to the right of the timeline
    var timelineStageContentParentData =
        timelineStageContent.parentData as TimelineRowParentData;
    timelineStageContentParentData.offset = Offset(
      leftTimelineNodeSpiral.size.width + stagePadding,
      0.0,
    );

    // position the rightTimelineNodeSpiral to the right of the content
    var rightTimelineNodeSpiralParentData =
        rightTimelineNodeSpiral.parentData as TimelineRowParentData;
    rightTimelineNodeSpiralParentData.offset = Offset(
      leftTimelineNodeSpiral.size.width +
          stagePadding +
          timelineStageContent.size.width +
          stagePadding,
      0.0,
    );

    // set the new size to the original width, but with the height of the timeline
    size = Size(constraints.maxWidth, timelineStageContent.size.height);
  }
}

class TimelineRowParentData extends ContainerBoxParentData<RenderBox>
    with ContainerParentDataMixin<RenderBox> {}
