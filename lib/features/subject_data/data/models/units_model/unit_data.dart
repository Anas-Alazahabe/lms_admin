import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';

import 'lesson.dart';

class UnitData extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final int? videoId;
  final int? fileId;
  final String? subjectId;
  final List<Lesson>? lessons;
  final List<Filee>? files;
  final List<Video>? videos;
  final List<int>? image;

  const UnitData({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.videoId,
    this.fileId,
    this.subjectId,
    this.lessons,
    this.files,
    this.videos,
    this.image,
  });

  factory UnitData.fromJson(Map<String, dynamic> json) {
    // print(json);
    return UnitData(
      id: json['id'].toString(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      videoId: json['video_id'] as int?,
      fileId: json['file_id'] as int?,
      subjectId: json['subject_id'].toString(),
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => Filee.fromJson(e as Map<String, dynamic>))
          .toList(),
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image_url': imageUrl,
        'video_id': videoId,
        'file_id': fileId,
        'subject_id': subjectId,
        'lessons': lessons?.map((e) => e.toJson()).toList(),
        'files': files?.map((e) => e.toJson()).toList(),
        'videos': videos?.map((e) => e.toJson()).toList(),
      };
  Map<String, dynamic> toUploadJson() => {
        'name': name,
        'description': description,
        'image': MultipartFile.fromBytes(image!, filename: name),
        'subject_id': subjectId,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      imageUrl,
      videoId,
      fileId,
      subjectId,
      lessons,
      files,
      videos,
    ];
  }
}
