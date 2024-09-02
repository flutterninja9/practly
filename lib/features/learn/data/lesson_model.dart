import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practly/core/enums/enums.dart';

import 'package:practly/core/models/excercise.dart';

class LessonModel {
  final String id;
  final String title;
  final String description;
  final List<Exercise>? exercises;

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.exercises,
  });

  LessonModel copyWith({
    String? id,
    String? title,
    String? description,
    List<Exercise>? exercises,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'exercises': exercises?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory LessonModel.fromMap(
    String id,
    Map<String, dynamic> map,
    Complexity? complexity,
  ) {
    return LessonModel(
      id: id,
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

  factory LessonModel.fromJson(
          String source, String id, Complexity? complexity) =>
      LessonModel.fromMap(
        id,
        json.decode(source) as Map<String, dynamic>,
        complexity,
      );

  @override
  String toString() =>
      'LessonModel(title: $title, description: $description, exercises: $exercises)';

  @override
  bool operator ==(covariant LessonModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.id == id &&
        listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ exercises.hashCode;
}
