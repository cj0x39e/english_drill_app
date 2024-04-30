import 'dart:io';
import 'package:args/args.dart';

/// Replace the running book name before debugging or building
void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addMultiOption(
      'book-name',
    );

  ArgResults argResults = parser.parse(arguments);
  final bookName = argResults.multiOption('book-name')[0];

  final specification = File('pubspec.yaml');

  String text = await specification.readAsString();

  text = text.replaceAll(RegExp(r'- assets\/nce\d\/'), '- assets/$bookName/');

  await specification.writeAsString(text);

  print('Current book name: $bookName');
}
