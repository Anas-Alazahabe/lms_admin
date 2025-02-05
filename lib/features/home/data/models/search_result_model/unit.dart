import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final String? imageData;
  final int? videoId;
  final int? fileId;
  final int? subjectId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Unit({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageData,
    this.videoId,
    this.fileId,
    this.subjectId,
    this.createdAt,
    this.updatedAt,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'] as int?,
        imageData: json['image_data'] as String?,
        videoId: json['video_id'] as int?,
        fileId: json['file_id'] as int?,
        subjectId: json['subject_id'] as int?,
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
        'description': description,
        'price': price,
        'image_data': imageData,
        'video_id': videoId,
        'file_id': fileId,
        'subject_id': subjectId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      imageData,
      videoId,
      fileId,
      subjectId,
      createdAt,
      updatedAt,
    ];
  }
}
