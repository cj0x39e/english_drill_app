import 'dart:convert';

import 'package:english_drill_app/models/lesson_model.dart';
import 'package:english_drill_app/pages/playing_page.dart';
import 'package:english_drill_app/utils/colors.dart';
import 'package:english_drill_app/utils/env.dart';
import 'package:english_drill_app/utils/parse_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonListPage extends StatefulWidget {
  const LessonListPage({super.key});

  @override
  State<LessonListPage> createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  List<LessonModel> lessons = [];

  _loadSourceMap() async {
    String jsonText = await rootBundle.loadString(getSourceMapPath());
    List<dynamic> jsonData = json.decode(jsonText);

    setState(() {
      lessons = jsonData.map((e) => LessonModel.fromJson(e)).toList();
      lessons.sort(
        (a, b) {
          return a.lessonNumber.compareTo(b.lessonNumber);
        },
      );
    });
  }

  _toPlayingPage(LessonModel lesson) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlayingPage(lesson: lesson);
    }));
  }

  @override
  void initState() {
    super.initState();

    _loadSourceMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson List'),
      ),
      body: ListView(
        children: [
          ...List.generate(lessons.length, (index) {
            final lesson = lessons[index];

            return Column(
              children: [
                ListTile(
                  leading: Text(
                    lesson.lessonNumber,
                    style: const TextStyle(color: mainColor),
                  ),
                  title: Text.rich(buildWordsWithBoldFirstLetter(lesson.title)),
                  onTap: () => _toPlayingPage(lesson),
                ),
                const Divider(height: 0)
              ],
            );
          })
        ],
      ),
    );
  }
}
