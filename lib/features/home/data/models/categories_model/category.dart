import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Categoryy extends Equatable {
  final int? id;
  final String? category;
  final dynamic imageUrl;
  final dynamic deletedAt;
  final List<int>? image;
  // final Uint8List? image;
  final String? newName;

  const Categoryy(
      {this.id,
      this.category,
      this.imageUrl,
      this.deletedAt,
      this.image,
      this.newName});

  factory Categoryy.fromJson(Map<String, dynamic> json) => Categoryy(
        id: json['id'] as int?,
        category: json['category'] as String?,
        imageUrl: json['image_url'] as dynamic,
        deletedAt: json['deleted_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'image_url': imageUrl,
        'deleted_at': deletedAt,
      };

  Map<String, dynamic> toUploadJson() => {
        'category': category,
        'image': MultipartFile.fromBytes(image!, filename: category),

        // 'image': MultipartFile.fromBytes(image!.toList(), filename: category),
      };

  Map<String, dynamic> toUpdateJson() {
    if (image == null) {
      return {
        'category': category,
        'new_category': newName,
      };
    }
    if (newName == category) {
      return {
        'category': category,
        'image': MultipartFile.fromBytes(image!, filename: category),

        // 'image': MultipartFile.fromBytes(image!.toList(), filename: category),
      };
    }
    return {
      'category': category,
      'new_category': newName,
      'image': MultipartFile.fromBytes(image!, filename: category),

      // 'image': MultipartFile.fromBytes(image!.toList(), filename: category),
    };
  }

  @override
  List<Object?> get props => [id, category, imageUrl, deletedAt, image];
}
