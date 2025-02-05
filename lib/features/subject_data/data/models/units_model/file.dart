import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Filee extends Equatable {
  final int? id;
  final String? name;
  final String? fileUrl;
  final List<int>? file;
  final String? subjectId;
  final String? unitId;
  final String? lessonId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Filee({
    this.id,
    this.name,
    this.fileUrl,
    this.subjectId,
    this.unitId,
    this.lessonId,
    this.createdAt,
    this.updatedAt,
    this.file
  });

  factory Filee.fromJson(Map<String, dynamic> json) => Filee(
        id: json['id'] as int?,
        name: json['name'] as String?,
        fileUrl: json['file'] as String?,
        subjectId: json['subject_id'].toString(),
        unitId: json['unit_id'].toString(),
        lessonId: json['lesson_id'].toString(),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': fileUrl,
        'subject_id': subjectId,
        'unit_id': unitId,
        'lesson_id': lessonId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };





 Map<String, dynamic> toUploadJson() => {
        // 'id': id,
        'name': name,
        'file': MultipartFile.fromBytes(file!, filename: name),
        'subject_id': subjectId,
        'unit_id': unitId,
        'lesson_id': lessonId,
        // 'created_at': createdAt?.toIso8601String(),
        // 'updated_at': updatedAt?.toIso8601String(),
      };







  @override
  List<Object?> get props {
    return [
      id,
      name,
      fileUrl,
      subjectId,
      unitId,
      lessonId,
      createdAt,
      updatedAt,
    ];
  }
}
