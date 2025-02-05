import 'package:equatable/equatable.dart';

class Pivot extends Equatable {
	final int? userId;
	final int? subjectId;

	const Pivot({this.userId, this.subjectId});

	factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
				userId: json['user_id'] as int?,
				subjectId: json['subject_id'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'user_id': userId,
				'subject_id': subjectId,
			};

	@override
	List<Object?> get props => [userId, subjectId];
}
