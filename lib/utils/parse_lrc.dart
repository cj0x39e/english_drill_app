import 'package:english_drill_app/models/lesson_fragment_model.dart';

double convertTimeStringToSeconds(String time) {
  List<String> timeList = time.split(':');
  return double.parse(timeList[0]) * 60 + double.parse(timeList[1]);
}

List<LessonFragmentModel> parseLRC(String lrc) {
  List<String> lines = lrc.split('\n');
  List<LessonFragmentModel> lrcList = [];
  final timeFlag = RegExp(r'^\[\d\d:\d\d\.\d\d\]');
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    if (line.startsWith(timeFlag)) {
      String timeString = line.substring(1, line.indexOf(']'));
      String text = line.substring(line.indexOf(']') + 1);
      double beginTime = convertTimeStringToSeconds(timeString);

      lrcList.add(LessonFragmentModel(
        index: i,
        words: text,
        beginTime: beginTime,
      ));
    }
  }

  for (int i = 0; i < lrcList.length - 1; i++) {
    lrcList[i].setEndTime(lrcList[i + 1].beginTime - 0.5);
  }

  return lrcList;
}
