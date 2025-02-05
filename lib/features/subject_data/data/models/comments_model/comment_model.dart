import 'package:equatable/equatable.dart';

import 'comment_data.dart';

class CommentModel extends Equatable {
  final CommentData? data;

  const CommentModel({this.data});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
      data: json['data'] == null
          ? null
          : CommentData.fromJson(json['data'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        'data': data,
      };

  @override
  List<Object?> get props => [data];
}
