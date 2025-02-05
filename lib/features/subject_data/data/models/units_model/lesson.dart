import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/video.dart';

class Lesson extends Equatable {
  final String? id;
  final String? name;
  final String? unitId;
  final String? price;
  final String? description;
  final String? imageUrl;
  final List<Filee>? files;
  final List<Video>? videos;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<int>? image;

  const Lesson({
    this.id,
    this.name,
    this.unitId,
    this.price,
    this.description,
    this.imageUrl,
    this.videos,
    this.files,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'].toString(),
        name: json['name'] as String?,
        unitId: json['unit_id'].toString(),
        price: json['price'].toString(),
        description: json['description'] as String?,
        imageUrl: json['image'] as String?,
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => Filee.fromJson(e as Map<String, dynamic>))
            .toList(),
        videos: (json['videos'] as List<dynamic>?)
            ?.map((e) => Video.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        'unit_id': unitId,
        'price': price,
        'description': description,
        'image': imageUrl,
        'files': files?.map((e) => e.toJson()).toList(),
        'videos': videos?.map((e) => e.toJson()).toList(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toUploadJson() => {
        'name': name,
        'description': description,
        'image': MultipartFile.fromBytes(image!, filename: name),
        'unit_id': unitId,
        'price': price,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      unitId,
      price,
      description,
      imageUrl,
      files,
      videos,
      createdAt,
      updatedAt,
    ];
  }
}
