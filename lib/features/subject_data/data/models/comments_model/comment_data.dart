import 'package:equatable/equatable.dart';

import 'reply.dart';

class CommentData extends Equatable {
  final int? id;
  final String? comment;
  // final dynamic parentId;
  final String? name;
  final String? imageIndex;

  final List<Reply>? replies;

  const CommentData(
      {this.id, this.comment, this.name, this.replies, this.imageIndex});

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json['Id'] as int?,
        comment: json['Text'] as String?,
        name: json['name'] as String?,
        replies: (json['Replies'] as List<dynamic>?)
            ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
            .toList(),
        imageIndex: json['user_image']?.toString(),
      );
  factory CommentData.fromSingleJson(Map<String, dynamic> json) => CommentData(
        id: json['Id'] as int?,
        comment: json['Text'] as String?,
        name: json['name'] as String?,
        imageIndex: json['user_image']?.toString(),
        replies: (json['Replies'] as List<dynamic>?)
            ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'Text': comment,
        'name': name,
        'user_image': imageIndex,
        'Replies': replies?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      comment,
      name,
      replies,
      imageIndex,
    ];
  }
}
