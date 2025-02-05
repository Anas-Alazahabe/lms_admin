import 'package:equatable/equatable.dart';

import 'category.dart';

class CategoriesModel extends Equatable {
  final String? message;
  final List<Categoryy>? categories;
  final Categoryy? singleCategory;

  const CategoriesModel({this.message, this.categories, this.singleCategory});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      message: json['message'] as String?,
      categories: (json['Categories:'] as List<dynamic>?)
          ?.map((e) => Categoryy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory CategoriesModel.fromSingleJson(Map<String, dynamic> json) {
    return CategoriesModel(
      message: json['message'] as String?,
      singleCategory:
          Categoryy.fromJson(json['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'Categories:': categories?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [message, categories];
}
