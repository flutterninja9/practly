import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practly/core/enums/enums.dart';

import 'package:practly/core/models/excercise.dart';

class DailyDialogModel {
  final String title;
  final String description;
  final List<Exercise>? exercises;

  DailyDialogModel({
    required this.title,
    required this.description,
    required this.exercises,
  });

  DailyDialogModel copyWith({
    String? title,
    String? description,
    List<Exercise>? exercises,
  }) {
    return DailyDialogModel(
      title: title ?? this.title,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'exercises': exercises?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory DailyDialogModel.fromMap(
    Map<String, dynamic> map,
    WordComplexity? complexity,
  ) {
    return DailyDialogModel(
      title: map['title'] as String,
      description: map['description'] as String,
      exercises: List<Exercise>.from(
        (map['exercises'] as List?)?.map<Exercise>(
              (x) => Exercise.fromMap(
                x as Map<String, dynamic>,
                complexity,
              ),
            ) ??
            [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyDialogModel.fromJson(
          String source, WordComplexity? complexity) =>
      DailyDialogModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
        complexity,
      );

  @override
  String toString() =>
      'DailyDialog(title: $title, description: $description, exercises: $exercises)';

  @override
  bool operator ==(covariant DailyDialogModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ exercises.hashCode;
}
