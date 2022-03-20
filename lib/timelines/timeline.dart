import 'package:article/timelines/custom_multi_child_layout_timeline.dart';
import 'package:article/timelines/intrinsic_height_timeline.dart';
import 'package:article/timelines/multi_child_render_object_widget_timeline.dart';
import 'package:article/widgets/timeline_stage_content.dart';
import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'A History of Flutter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.0,
              ),
            ),
            const SizedBox(height: 8.0),
            IntrinsicHeightTimeline(stages: stages),
            //CustomMultiChildLayoutTimeline(stages: stages), // DOES NOT WORK
            //MultiChildRenderObjectWidgetTimeline(stages: stages),
          ],
        ),
      ),
    );
  }

  List<TimelineStageContent> get stages => [
        const TimelineStageContent(
          year: 2015,
          eventTitle: 'Flutter announced',
          subtitle: 'November 2015 - Google announces Flutter',
          body: [
            'At this point Flutter had no IDE, no Windows support, no deployment tools, and barely any documentation.'
          ],
        ),
        const TimelineStageContent(
          year: 2017,
          eventTitle: 'Initial alpha release',
          subtitle: 'May 2017 - Alpha (v0.0.6)',
        ),
        const TimelineStageContent(
          year: 2018,
          eventTitle: 'Initial stable release',
          subtitle: 'December 2018 - Stable (v1.0.0)',
          body: [
            'The first stable version of Flutter was released as part of the Flutter Live event.'
          ],
        ),
        const TimelineStageContent(
          year: 2019,
          eventTitle: 'Desktop and Web',
          body: [
            'At Google I/0, Flutter support for Desktop and Web is announced.'
          ],
        ),
        const TimelineStageContent(
          year: 2020,
          eventTitle: 'Flutter surpasses React Native',
          body: [
            'In January of 2020, Flutter passed React Native in Github stars.'
          ],
        ),
        const TimelineStageContent(
          year: 2021,
          eventTitle: 'Flutter 2 Release',
          subtitle: 'March 2021 - v2.0.0',
          body: [
            'Flutter 2 dropped on March 3rd alongside Dart 2.12, bringing Null Safety into the framework.',
            'What is next for Flutter? Only time will tell!',
          ],
        ),
      ];
}
