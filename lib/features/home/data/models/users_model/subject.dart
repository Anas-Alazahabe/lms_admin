import 'package:equatable/equatable.dart';

import 'pivot.dart';

class Subject extends Equatable {
	final int? id;
	final String? name;
	final String? description;
	final int? price;
	final int? categoryId;
	final dynamic imageUrl;
	final dynamic videoId;
	final dynamic fileId;
	final int? exist;
	final Pivot? pivot;

	const Subject({
		this.id, 
		this.name, 
		this.description, 
		this.price, 
		this.categoryId, 
		this.imageUrl, 
		this.videoId, 
		this.fileId, 
		this.exist, 
		this.pivot, 
	});

	factory Subject.fromJson(Map<String, dynamic> json) => Subject(
				id: json['id'] as int?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				price: json['price'] as int?,
				categoryId: json['category_id'] as int?,
				imageUrl: json['image_url'] as dynamic,
				videoId: json['video_id'] as dynamic,
				fileId: json['file_id'] as dynamic,
				exist: json['exist'] as int?,
				pivot: json['pivot'] == null
						? null
						: Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'description': description,
				'price': price,
				'category_id': categoryId,
				'image_url': imageUrl,
				'video_id': videoId,
				'file_id': fileId,
				'exist': exist,
				'pivot': pivot?.toJson(),
			};

	@override
	List<Object?> get props {
		return [
				id,
				name,
				description,
				price,
				categoryId,
				imageUrl,
				videoId,
				fileId,
				exist,
				pivot,
		];
	}
}
