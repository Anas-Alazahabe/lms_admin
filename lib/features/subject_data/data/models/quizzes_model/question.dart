import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int? id;
  final String? text;
  final List<dynamic>? answers;
  final String? correctAnswer;
  final String? mark;
  final int? quizId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Question({
    this.id,
    this.text,
    this.answers,
    this.correctAnswer,
    this.mark,
    this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    print(json['answers']);
    print(json);
    return Question(
      id: json['id'] as int?,
      text: json['text'] as String?,
      answers:json['answers'] !=null? json['answers'] as List<dynamic>?:null,
      correctAnswer: json['correct_answer'] as String?,
      mark: json['mark']?.toString(),
      quizId: json['quiz_id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'answers': answers,
        'correct_answer': correctAnswer,
        'mark': mark,
        'quiz_id': quizId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      text,
      answers,
      correctAnswer,
      mark,
      quizId,
      createdAt,
      updatedAt,
    ];
  }
}
