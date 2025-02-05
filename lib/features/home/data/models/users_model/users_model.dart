import 'package:equatable/equatable.dart';

import 'datum.dart';

class UsersModel extends Equatable {
	final String? message;
	final List<Datum>? data;

	const UsersModel({this.message, this.data});

	factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
				message: json['status'] as String?,
				data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'message': message,
				'data': data?.map((e) => e.toJson()).toList(),
			};

	@override
	List<Object?> get props => [message, data];
}
