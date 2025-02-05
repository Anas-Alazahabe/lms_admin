import 'package:equatable/equatable.dart';

import 'question.dart';

class Quiz extends Equatable {
  final int? id;
  final String? name;
  final String? duration;
  final String? totalMark;
  final String? successMark;
  final bool? public;
  final String? typeType;
  final String? typeId;
  final int? teacherId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Question>? questions;

  const Quiz({
    this.id,
    this.name,
    this.duration,
    this.totalMark,
    this.successMark,
    this.public,
    this.typeType,
    this.typeId,
    this.teacherId,
    this.createdAt,
    this.updatedAt,
    this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json['id'] as int?,
        name: json['name'] as String?,
        duration: json['duration']?.toString(),
        totalMark: json['total_mark']?.toString(),
        successMark: json['success_mark']?.toString(),
        public: json['public'] is bool?,//TODO fix this
        typeType: json['type_type']?.toString(),
        typeId: json['type_id']?.toString(),
        teacherId: json['teacher_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        questions: (json['questions'] as List<dynamic>?)
            ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration': duration,
        'total_mark': totalMark,
        'success_mark': successMark,
        'public': public,
        'type_type': typeType,
        'type_id': typeId,
        'teacher_id': teacherId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'questions': questions?.map((e) => e.toJson()).toList(),
      };
   Map<String, dynamic> toAddQuizJson() => {
        // 'id': id,
        'name': name,
        'duration': duration,
        // 'total_mark': totalMark,
        'success_mark': successMark,
        'public': public,
        'type_type': typeType,
        'type_id': typeId,
        // 'teacher_id': teacherId,
        // 'created_at': createdAt?.toIso8601String(),
        // 'updated_at': updatedAt?.toIso8601String(),
        'questions': questions?.map((e) => e.toJson()).toList(),
      };


  @override
  List<Object?> get props {
    return [
      id,
      name,
      duration,
      totalMark,
      successMark,
      public,
      typeType,
      typeId,
      teacherId,
      createdAt,
      updatedAt,
      questions,
    ];
  }
}
