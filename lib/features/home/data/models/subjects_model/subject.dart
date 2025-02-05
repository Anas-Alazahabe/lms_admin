import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lms_admin/features/auth/data/models/user_model/user.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/year.dart';
import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';

class Subject extends Equatable {
  String? name;
  String? price;
  String? description;
  String? imageUrl;
  // File? image;
  List<int>? image;
  String? videoId;
  String? fileId;
  String? categoryId;
  String? updatedAt;
  String? createdAt;
    final  List<Filee>? files;

  String? id;
  List<YearsContent>? yearsContent;
  List<User>? users;

  Subject(
      {this.name,
      this.price,
      this.description,
      this.imageUrl,
      this.image,
      this.videoId,
      this.fileId,
      this.categoryId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.files, 
      this.yearsContent,
      this.users});

  factory Subject.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Subject(
      name: json["name"],
                  files: (json['files'] as List<dynamic>?)
          ?.map((e) => Filee.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json["price"].toString(),
      description: json["description"],
      imageUrl: json["image_url"],
      videoId: json["video_id"].toString(),
      fileId: json["file_id"].toString(),
      categoryId: json["category_id"].toString(),
      updatedAt: json["updated_at"],
      createdAt: json["created_at"],
      id: json["id"].toString(),
      // yearsContent = json["years_content"] == null ? null : (json["years_content"] as List).map((e) => YearsContent.fromJson(e)).toList();
      // users = json["users"] == null ? null : (json["users"] as List).map((e) => User.fromJson(e)).toList();
    );
  }
  Map<String, dynamic> toJson() => {
        'subject_id': id,
        'category_id': categoryId,
        'name': name,
        'price': price.toString(),
        'description': description,
        'image': image == null
            ? null
            : MultipartFile.fromBytes(image!, filename: name),
        'video_id': videoId,
        'file_id': fileId,
        'files': files?.map((e) => e.toJson()).toList(),
        'years_content': yearsContent?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        name,
        price,
        description,
        imageUrl,
        image,
        videoId,
        fileId,
        categoryId,
        updatedAt,
        createdAt,
        id,
        yearsContent,
        users
      ];
}

// import 'package:equatable/equatable.dart';
// import 'package:lms_admin/features/auth/data/models/user_model/user.dart';

// class Subject extends Equatable {
// 	final int? id;
// 	final String? name;
// 	final String? description;
// 	final int? price;
// 	final int? categoryId;
// 	final String? imageData;
// 	final dynamic videoId;
// 	final dynamic fileId;
// 	final DateTime? createdAt;
// 	final DateTime? updatedAt;
// 	final List<User>? users;

// 	const Subject({
// 		this.id,
// 		this.name,
// 		this.description,
// 		this.price,
// 		this.categoryId,
// 		this.imageData,
// 		this.videoId,
// 		this.fileId,
// 		this.createdAt,
// 		this.updatedAt,
// 		this.users,
// 	});

// 	factory Subject.fromJson(Map<String, dynamic> json) => Subject(
// 				id: json['id'] as int?,
// 				name: json['name'] as String?,
// 				description: json['description'] as String?,
// 				price: json['price'] as int?,
// 				categoryId: json['category_id'] as int?,
// 				imageData: json['image_data'] as String?,
// 				videoId: json['video_id'] as dynamic,
// 				fileId: json['file_id'] as dynamic,
// 				createdAt: json['created_at'] == null
// 						? null
// 						: DateTime.parse(json['created_at'] as String),
// 				updatedAt: json['updated_at'] == null
// 						? null
// 						: DateTime.parse(json['updated_at'] as String),
// 				users: (json['users'] as List<dynamic>?)
// 						?.map((e) => User.fromJson(e as Map<String, dynamic>))
// 						.toList(),
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'id': id,
// 				'name': name,
// 				'description': description,
// 				'price': price,
// 				'category_id': categoryId,
// 				'image_data': imageData,
// 				'video_id': videoId,
// 				'file_id': fileId,
// 				'created_at': createdAt?.toIso8601String(),
// 				'updated_at': updatedAt?.toIso8601String(),
// 				'users': users?.map((e) => e.toJson()).toList(),
// 			};

// 	@override
// 	List<Object?> get props {
// 		return [
// 				id,
// 				name,
// 				description,
// 				price,
// 				categoryId,
// 				imageData,
// 				videoId,
// 				fileId,
// 				createdAt,
// 				updatedAt,
// 				users,
// 		];
// 	}
// }
