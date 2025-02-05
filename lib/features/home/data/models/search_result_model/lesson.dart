// import 'package:equatable/equatable.dart';

// class Lesson extends Equatable {
// 	final int? id;
// 	final String? name;
// 	final int? unitId;
// 	final int? price;
// 	final String? description;
// 	final String? image;
// 	final String? file;
// 	final String? video;
// 	final DateTime? createdAt;
// 	final DateTime? updatedAt;

// 	const Lesson({
// 		this.id,
// 		this.name,
// 		this.unitId,
// 		this.price,
// 		this.description,
// 		this.image,
// 		this.file,
// 		this.video,
// 		this.createdAt,
// 		this.updatedAt,
// 	});

// 	factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
// 				id: json['id'] as int?,
// 				name: json['name'] as String?,
// 				unitId: json['unit_id'] as int?,
// 				price: json['price'] as int?,
// 				description: json['description'] as String?,
// 				image: json['image'] as String?,
// 				file: json['file'] as String?,
// 				video: json['video'] as String?,
// 				createdAt: json['created_at'] == null
// 						? null
// 						: DateTime.parse(json['created_at'] as String),
// 				updatedAt: json['updated_at'] == null
// 						? null
// 						: DateTime.parse(json['updated_at'] as String),
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'id': id,
// 				'name': name,
// 				'unit_id': unitId,
// 				'price': price,
// 				'description': description,
// 				'image': image,
// 				'file': file,
// 				'video': video,
// 				'created_at': createdAt?.toIso8601String(),
// 				'updated_at': updatedAt?.toIso8601String(),
// 			};

// 	@override
// 	List<Object?> get props {
// 		return [
// 				id,
// 				name,
// 				unitId,
// 				price,
// 				description,
// 				image,
// 				file,
// 				video,
// 				createdAt,
// 				updatedAt,
// 		];
// 	}
// }
