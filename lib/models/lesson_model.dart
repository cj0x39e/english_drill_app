class LessonModel {
  final String lessonNumber;
  final String title;
  final String audioPath;
  final String lrcPath;

  LessonModel(
      {required this.lessonNumber,
      required this.title,
      required this.audioPath,
      required this.lrcPath});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
        lessonNumber: json['lessonNumber'],
        title: json['title'],
        audioPath: json['audioPath'],
        lrcPath: json['lrcPath']);
  }
}
