import 'package:english_drill_app/models/lesson_fragment_model.dart';
import 'package:english_drill_app/models/lesson_model.dart';
import 'package:english_drill_app/utils/parse_lrc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayingPage extends StatefulWidget {
  final LessonModel lesson;

  const PlayingPage({super.key, required this.lesson});

  @override
  State<PlayingPage> createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  List<LessonFragmentModel> lrcList = [];
  LessonFragmentModel? activeFragment;

  _parseLrc() async {
    final lrcText = await rootBundle.loadString(widget.lesson.lrcPath);

    final list = parseLRC(lrcText);

    setState(() {
      lrcList = list;
      activeFragment = list.first;
    });
  }

  @override
  void initState() {
    super.initState();
    _parseLrc();
  }

  TextSpan buildFragment(LessonFragmentModel fragment) {
    final active = activeFragment == fragment;
    final color = active ? Colors.blue : Colors.grey[500];
    final style =
        active ? TextDecorationStyle.solid : TextDecorationStyle.dotted;
    return TextSpan(children: [
      TextSpan(
        text: fragment.words,
        style: TextStyle(
            fontSize: 22,
            height: 1.8,
            decorationStyle: style,
            decorationColor: color,
            decoration: TextDecoration.underline),
      ),
      const TextSpan(text: '  ')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text.rich(TextSpan(
              children: List.generate(
                  lrcList.length, (index) => buildFragment(lrcList[index]))))
        ]),
      ),
    );
  }
}
