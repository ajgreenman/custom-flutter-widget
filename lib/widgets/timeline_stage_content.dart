import 'package:flutter/material.dart';

class TimelineStageContent extends StatelessWidget {
  const TimelineStageContent({
    Key? key,
    required this.year,
    required this.eventTitle,
    this.subtitle,
    this.body,
  }) : super(key: key);

  final int year;
  final String eventTitle;
  final String? subtitle;
  final List<String>? body;

  static const fontFamily = 'GTA';
  static const monoFontFamily = 'GTAM';

  TextStyle get _titleTextStyle => const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontFamily: fontFamily,
      );

  TextStyle get _subtitleTextStyle => const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontFamily: monoFontFamily,
      );

  TextStyle get _bodyTextStyle => const TextStyle(
        color: Colors.black,
        fontSize: 12.0,
        fontFamily: fontFamily,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$year',
                style: _titleTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' - $eventTitle',
                style: _titleTextStyle.copyWith(),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: _subtitleTextStyle,
          ),
        ],
        if (body != null)
          ...body!
              .map(
                (b) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    b,
                    style: _bodyTextStyle,
                  ),
                ),
              )
              .toList(),
      ],
    );
  }
}
