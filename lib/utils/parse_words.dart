import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

int findFirstLetter(String? word) {
  if (word == null) return -1;

  return word.indexOf(RegExp(r'[a-zA-Z]'));
}

TextSpan buildWordWithBoldFirstLetter(String word, {Function()? onTap}) {
  final firstLetterIndex = findFirstLetter(word);

  if (firstLetterIndex != -1) {
    String? before;
    String? after;

    if (firstLetterIndex > 0) {
      before = word.substring(0, firstLetterIndex);
    }

    if (firstLetterIndex < word.length - 1) {
      after = word.substring(firstLetterIndex + 1);
    }

    final firstLetter = word[firstLetterIndex];

    TapGestureRecognizer? recognizer;

    if (onTap != null) {
      recognizer = TapGestureRecognizer()..onTap = () => onTap();
    }

    return TextSpan(
      children: [
        if (before != null)
          TextSpan(
            text: before,
            recognizer: recognizer,
          ),
        TextSpan(
          text: firstLetter,
          style: const TextStyle(fontWeight: FontWeight.bold),
          recognizer: recognizer,
        ),
        if (after != null)
          TextSpan(
            text: after,
            recognizer: recognizer,
          ),
      ],
    );
  } else {
    return TextSpan(text: word);
  }
}

TextSpan buildWordsWithBoldFirstLetter(String words, {Function()? onTap}) {
  final wordsList = words.split(' ');

  return TextSpan(children: [
    for (final word in wordsList) ...[
      buildWordWithBoldFirstLetter(word, onTap: onTap),
      if (word != wordsList.last) const TextSpan(text: ' ')
    ]
  ]);
}
