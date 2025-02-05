import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';

class SearchSubjectsModel extends Equatable {
  final String? message;
  final List<Subject>? subjects;

  const SearchSubjectsModel({this.message, this.subjects});

  factory SearchSubjectsModel.fromJson(Map<String, dynamic> json) =>
      SearchSubjectsModel(
        message: json['message'] as String?,
        subjects: (json['subjects'] as List<dynamic>?)
            ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': subjects?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [message, subjects];
}
