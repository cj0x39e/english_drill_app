import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:english_drill_app/models/lesson_fragment_model.dart';
import 'package:english_drill_app/models/lesson_model.dart';
import 'package:english_drill_app/utils/colors.dart';
import 'package:english_drill_app/utils/parse_lrc.dart';
import 'package:english_drill_app/utils/parse_words.dart';
import 'package:flutter/gestures.dart';
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
  Map<int, LessonFragmentModel> lrcMap = {};
  LessonFragmentModel? activeFragment;
  late Audio audio;
  bool playingArticle = false;
  bool playingFragment = false;
  double positionOfArticle = 0;
  double activeIndexOfFragment = 0;

  _playFragment(LessonFragmentModel fragment) {
    setState(() {
      playingArticle = false;
      playingFragment = true;
      activeFragment = fragment;
    });
    audio.play();
    audio.seek(fragment.beginTime);
  }

  _play() {
    setState(() {
      playingArticle = true;
      playingFragment = false;

      audio.play();
      audio.seek(positionOfArticle);
    });
  }

  _pause() {
    setState(() {
      playingArticle = false;
      audio.pause();
    });
  }

  _toggle() {
    if (playingArticle) {
      _pause();
    } else {
      _play();
    }
  }

  _loadAudio() {
    audio = Audio.load(
      widget.lesson.audioPath,
      playInBackground: true,
      onPosition: (position) {
        setState(() {
          if (playingArticle) {
            positionOfArticle = position;

            // if (activeFragment? &&
            //     position > lrcMap[activeIndexOfFragment]!.beginTime) {
            //   activeFragment = lrcMap[activeIndexOfFragment];
            // }
          } else if (playingFragment) {
            if (activeFragment?.endTime != null &&
                position >= activeFragment!.endTime!) {
              _pause();
            }
          }
        });
      },
      onComplete: () {
        if (playingArticle) {
          positionOfArticle = 0;
          _play();
        }
      },
    );
  }

  _parseLrc() async {
    final lrcText = await rootBundle.loadString(widget.lesson.lrcPath);

    final list = parseLRC(lrcText);

    setState(() {
      lrcList = list;
      lrcMap = Map.fromEntries(list.map((e) => MapEntry(e.index, e)));
    });
  }

  @override
  void initState() {
    super.initState();
    _parseLrc();
    _loadAudio();
  }

  @override
  void dispose() {
    audio.pause();
    audio.dispose();
    super.dispose();
  }

  TextSpan buildFragment(LessonFragmentModel fragment) {
    final active = activeFragment == fragment;
    final color = active ? mainColor : Colors.grey[600];
    final style =
        active ? TextDecorationStyle.solid : TextDecorationStyle.dotted;

    return TextSpan(children: [
      TextSpan(
          style: TextStyle(
            fontSize: 22,
            height: 1.8,
            decorationStyle: style,
            color: color,
            decorationColor: color,
            decoration: TextDecoration.underline,
          ),
          children: [
            buildWordsWithBoldFirstLetter(fragment.words,
                onTap: () => _playFragment(fragment))
          ]),
      const TextSpan(text: '  ')
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Text.rich(TextSpan(
                children: List.generate(
                    lrcList.length, (index) => buildFragment(lrcList[index])))),
            const SizedBox(
              height: 60,
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: Icon(playingArticle ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
