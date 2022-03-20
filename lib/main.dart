import 'package:article/timelines/timeline.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const stagePadding = 16.0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Widget Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widget Demo'),
      ),
      body: const SingleChildScrollView(
        child: Timeline(),
      ),
    );
  }
}
