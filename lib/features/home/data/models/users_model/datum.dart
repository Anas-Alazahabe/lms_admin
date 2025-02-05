import 'package:equatable/equatable.dart';

import 'subject.dart';

class Datum extends Equatable {
	final int? id;
	final String? name;
	final String? email;
	final String? emailSentAt;
	final dynamic deviceId;
	final dynamic verificationCode;
	final int? imageId;
	final String? birthDate;
	final int? gender;
	final int? addressId;
	final String? roleId;
	final dynamic stageId;
	final dynamic yearId;
	final int? points;
	final String? fcm;
	final int? balance;
	final int? exist;
	final List<Subject>? subjects;

	const Datum({
		this.id, 
		this.name, 
		this.email, 
		this.emailSentAt, 
		this.deviceId, 
		this.verificationCode, 
		this.imageId, 
		this.birthDate, 
		this.gender, 
		this.addressId, 
		this.roleId, 
		this.stageId, 
		this.yearId, 
		this.points, 
		this.fcm, 
		this.balance, 
		this.exist, 
		this.subjects, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as int?,
				name: json['name'] as String?,
				email: json['email'] as String?,
				emailSentAt: json['email_sent_at'] as String?,
				deviceId: json['device_id'] as dynamic,
				verificationCode: json['verificationCode'] as dynamic,
				imageId: json['image_id'] as int?,
				birthDate: json['birth_date'] as String?,
				gender: json['gender'] as int?,
				addressId: json['address_id'] as int?,
				roleId: json['role']?.toString(),
				stageId: json['stage_id'] as dynamic,
				yearId: json['year_id'] as dynamic,
				points: json['points'] as int?,
				fcm: json['fcm'] as String?,
				balance: json['balance'] as int?,
				exist: json['exist'] as int?,
				subjects: (json['subjects'] as List<dynamic>?)
						?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'email': email,
				'email_sent_at': emailSentAt,
				'device_id': deviceId,
				'verificationCode': verificationCode,
				'image_id': imageId,
				'birth_date': birthDate,
				'gender': gender,
				'address_id': addressId,
				'role_id': roleId,
				'stage_id': stageId,
				'year_id': yearId,
				'points': points,
				'fcm': fcm,
				'balance': balance,
				'exist': exist,
				'subjects': subjects?.map((e) => e.toJson()).toList(),
			};

	@override
	List<Object?> get props {
		return [
				id,
				name,
				email,
				emailSentAt,
				deviceId,
				verificationCode,
				imageId,
				birthDate,
				gender,
				addressId,
				roleId,
				stageId,
				yearId,
				points,
				fcm,
				balance,
				exist,
				subjects,
		];
	}
}
