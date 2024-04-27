import 'package:english_drill_app/models/lesson_fragment_model.dart';

int convertTimeStringToMilliseconds(String time) {
  List<String> timeList = time.split(':');
  final result =
      double.parse(timeList[0]) * 60 * 1000 + double.parse(timeList[1]) * 1000;
  return result.toInt();
}

List<LessonFragmentModel> parseLRC(String lrc) {
  List<String> lines = lrc.split('\n');
  List<LessonFragmentModel> lrcList = [];
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    if (line.startsWith('[')) {
      String timeString = line.substring(1, line.indexOf(']'));
      String text = line.substring(line.indexOf(']') + 1);
      int beginTime = convertTimeStringToMilliseconds(timeString);

      lrcList.add(LessonFragmentModel(words: text, beginTime: beginTime));
    }
  }
  return lrcList;
}
