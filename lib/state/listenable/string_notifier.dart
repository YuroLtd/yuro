import 'package:flutter/foundation.dart';
import 'package:yuro/state/obs.dart';

class StringNotifier extends ValueNotifier<String> with ValueNotifierMixin implements Comparable<String>, Pattern {
  StringNotifier(super.value);

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) => value.allMatches(string, start);

  @override
  Match? matchAsPrefix(String string, [int start = 0]) => value.matchAsPrefix(string, start);

  @override
  int compareTo(String other) => value.compareTo(other);

  String operator [](int index) => value[index];

  int codeUnitAt(int index) => value.codeUnitAt(index);

  int get length => value.length;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) => value == other;

  bool endsWith(String other) => value.endsWith(other);

  bool startsWith(Pattern pattern, [int index = 0]) => value.startsWith(pattern, index);

  int indexOf(Pattern pattern, [int start = 0]) => value.indexOf(pattern, start);

  int lastIndexOf(Pattern pattern, [int? start]) => value.lastIndexOf(pattern, start);

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  String operator +(String other) => value + other;

  String substring(int start, [int? end]) => value.substring(start, end);

  String trim() => value.trim();

  String trimLeft() => value.trimLeft();

  String trimRight() => value.trimRight();

  String operator *(int times) => value * times;

  String padLeft(int width, [String padding = ' ']) => value.padLeft(width, padding);

  String padRight(int width, [String padding = ' ']) => value.padRight(width, padding);

  bool contains(Pattern other, [int startIndex = 0]) => value.contains(other, startIndex);

  String replaceFirst(Pattern from, String to, [int startIndex = 0]) => value.replaceFirst(from, to, startIndex);

  String replaceFirstMapped(Pattern from, String Function(Match match) replace, [int startIndex = 0]) =>
      value.replaceFirstMapped(from, replace, startIndex);

  String replaceAll(Pattern from, String replace) => value.replaceAll(from, replace);

  String replaceAllMapped(Pattern from, String Function(Match match) replace) => value.replaceAllMapped(from, replace);

  String replaceRange(int start, int? end, String replacement) => value.replaceRange(start, end, replacement);

  List<String> split(Pattern pattern) => value.split(pattern);

  String splitMapJoin(Pattern pattern, {String Function(Match)? onMatch, String Function(String)? onNonMatch}) =>
      value.splitMapJoin(pattern, onMatch: onMatch, onNonMatch: onNonMatch);

  List<int> get codeUnits => value.codeUnits;

  Runes get runes => value.runes;

  String toLowerCase() => value.toLowerCase();

  String toUpperCase() => value.toUpperCase();
}

extension StringNotifierExt on String {
  StringNotifier get obs => StringNotifier(this);
}

class NStringNotifier extends ValueNotifier<String?> implements Comparable<String>, Pattern {
  NStringNotifier([super.value]);

  @override
  Iterable<Match> allMatches(String string, [int start = 0]) => value?.allMatches(string, start) ?? [];

  @override
  Match? matchAsPrefix(String string, [int start = 0]) => value?.matchAsPrefix(string, start);

  @override
  int compareTo(String other) => value?.compareTo(other) ?? -1;

  String? operator [](int index) => value?[index];

  int? codeUnitAt(int index) => value?.codeUnitAt(index);

  int? get length => value?.length;

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) => value == other;

  bool endsWith(String other) => value?.endsWith(other) ?? false;

  bool startsWith(Pattern pattern, [int index = 0]) => value?.startsWith(pattern, index) ?? false;

  int indexOf(Pattern pattern, [int start = 0]) => value?.indexOf(pattern, start) ?? -1;

  int lastIndexOf(Pattern pattern, [int? start]) => value?.lastIndexOf(pattern, start) ?? -1;

  bool? get isEmpty => value?.isEmpty;

  bool? get isNotEmpty => value?.isNotEmpty;

  String operator +(String other) => (value ?? '') + other;

  String? substring(int start, [int? end]) => value?.substring(start, end);

  String? trim() => value?.trim();

  String? trimLeft() => value?.trimLeft();

  String? trimRight() => value?.trimRight();

  String? operator *(int times) => value == null ? null : value! * times;

  String? padLeft(int width, [String padding = ' ']) => value?.padLeft(width, padding);

  String? padRight(int width, [String padding = ' ']) => value?.padRight(width, padding);

  bool contains(Pattern other, [int startIndex = 0]) => value?.contains(other, startIndex) ?? false;

  String? replaceFirst(Pattern from, String to, [int startIndex = 0]) => value?.replaceFirst(from, to, startIndex);

  String? replaceFirstMapped(Pattern from, String Function(Match match) replace, [int startIndex = 0]) =>
      value?.replaceFirstMapped(from, replace, startIndex);

  String? replaceAll(Pattern from, String replace) => value?.replaceAll(from, replace);

  String? replaceAllMapped(Pattern from, String Function(Match match) replace) => value?.replaceAllMapped(from, replace);

  String? replaceRange(int start, int? end, String replacement) => value?.replaceRange(start, end, replacement);

  List<String>? split(Pattern pattern) => value?.split(pattern);

  String? splitMapJoin(Pattern pattern, {String Function(Match)? onMatch, String Function(String)? onNonMatch}) =>
      value?.splitMapJoin(pattern, onMatch: onMatch, onNonMatch: onNonMatch);

  List<int>? get codeUnits => value?.codeUnits;

  Runes? get runes => value?.runes;

  String? toLowerCase() => value?.toLowerCase();

  String? toUpperCase() => value?.toUpperCase();
}
