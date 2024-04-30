const String bookName = String.fromEnvironment(
  "BOOK_NAME",
);

String getSourceMapPath() {
  return 'assets/$bookName/source_map.json';
}
