class LessonFragmentModel {
  final double beginTime;
  final String words;
  final int index;

  double? _endTime;
  double? get endTime => _endTime;

  LessonFragmentModel(
      {required this.index, required this.beginTime, required this.words});

  setEndTime(double endTime) => _endTime = endTime;
}
