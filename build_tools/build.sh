# !/bin/bash

# Get the latest user-facing version number from pubspec.yaml
VERSION=$(grep "version:" pubspec.yaml | awk '{print $2}' | tr -d "'" | sed 's/[^A-Za-z0-9\.\-\+]//g')
APK_FILE=./build/app/outputs/flutter-apk/app-release.apk


for i in {1..4}; do
	dart run build_tools/replace_book.dart --book-name nce$i
	mkdir -p ./dist
	flutter build apk --dart-define="BOOK_NAME=nce$i" --no-tree-shake-icons --no-pub
	cp -f "$APK_FILE" "./dist/english_drill_nce${i}_$VERSION.apk" && echo "$APK_FILE"
	sleep 10
done

dart run build_tools/replace_book.dart --book-name nce2
