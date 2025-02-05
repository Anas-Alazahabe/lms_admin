import 'package:equatable/equatable.dart';

import 'comment_data.dart';

class CommentsModel extends Equatable {
  final List<CommentData>? data;

  const CommentsModel({this.data});

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => CommentData.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [data];
}
