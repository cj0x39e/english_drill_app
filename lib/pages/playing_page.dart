import 'package:english_drill_app/models/lesson_model.dart';
import 'package:flutter/material.dart';

class PlayingPage extends StatefulWidget {
  final LessonModel lesson;

  const PlayingPage({super.key, required this.lesson});

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
