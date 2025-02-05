import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/subject_data/data/models/quizzes_model/quiz.dart';


class QuizzesModel extends Equatable {
  final List<Quiz>? openQuizzes;
  final List<Quiz>? lockQuizzes;

  const QuizzesModel({this.openQuizzes, this.lockQuizzes});

  factory QuizzesModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return QuizzesModel(
      openQuizzes: (json['OpenQuizzes'] as List<dynamic>?)
          ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
      lockQuizzes: (json['LockQuizzes'] as List<dynamic>?)
          ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'OpenQuizzes': openQuizzes?.map((e) => e.toJson()).toList(),
        'LockQuizzes': lockQuizzes?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [openQuizzes, lockQuizzes];
}
