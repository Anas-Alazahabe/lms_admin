class Category {
  int? id;
  String? category;
  dynamic imageUrl;
  dynamic deletedAt;

  Category({this.id, this.category, this.imageUrl, this.deletedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    category = json["category"];
    imageUrl = json["image_url"];
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["category"] = category;
    _data["image_url"] = imageUrl;
    _data["deleted_at"] = deletedAt;
    return _data;
  }
}

// import 'package:equatable/equatable.dart';

// class Categoryy extends Equatable {
//   final int? id;
//   final String? category;
//   final dynamic imageUrl;
//   final dynamic deletedAt;

//   const Categoryy({this.id, this.category, this.imageUrl, this.deletedAt});

//   factory Categoryy.fromJson(Map<String, dynamic> json) => Categoryy(
//         id: json['id'] as int?,
//         category: json['category'] as String?,
//         imageUrl: json['image_url'] as dynamic,
//         deletedAt: json['deleted_at'] as dynamic,
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'category': category,
//         'image_url': imageUrl,
//         'deleted_at': deletedAt,
//       };

//   @override
//   List<Object?> get props => [id, category, imageUrl, deletedAt];
// }
