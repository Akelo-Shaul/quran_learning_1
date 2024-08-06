import 'dart:convert';

class Result{
  String? date,
  chapter,
  studentName,
  verse;

  Result({
    this.date,
    this.chapter,
    this.studentName,
    this.verse
  });

  static Result fromHomeJson(Map<String, String> json) {
    return Result(
      date: json['date'] ?? '',
      chapter: json['chapter'] ?? '',
      studentName: json['chapter'] ?? '',
      verse: json['verse'] ?? '',
    );
  }
}