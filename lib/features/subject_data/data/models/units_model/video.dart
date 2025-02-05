import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final int? id;

  final String? name;
  final String? videoUrl;
  final List<int>? video;
  final String? subjectId;
  final String? unitId;
  final String? lessonId;
  final String? adsId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Video(
      {this.id,
      this.name,
      this.videoUrl,
      this.subjectId,
      this.unitId,
      this.lessonId,
      this.adsId,
      this.createdAt,
      this.updatedAt,
      this.video});

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json['id'] as int?,
        name: json['name'] as String?,
        videoUrl: json['video'] as String?,
        subjectId: json['subject_id'].toString(),
        unitId: json['unit_id'].toString(),
        lessonId: json['lesson_id'].toString(),
        adsId: json['ads_id'].toString(),
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
        'video': videoUrl,
        'subject_id': subjectId,
        'unit_id': unitId,
        'lesson_id': lessonId,
        'ads_id': adsId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
  Map<String, dynamic> toUploadJson() => {
        // 'id': id,
        'name': name,
        'video': MultipartFile.fromBytes(video!, filename: name),
        'subject_id': subjectId,
        'unit_id': unitId,
        'lesson_id': lessonId,
        'ads_id': adsId,
        // 'created_at': createdAt?.toIso8601String(),
        // 'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      videoUrl,
      subjectId,
      unitId,
      lessonId,
      adsId,
      createdAt,
      updatedAt,
    ];
  }
}
