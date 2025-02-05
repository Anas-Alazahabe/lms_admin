import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
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
  final int? roleId;
  final dynamic stageId;
  final dynamic yearId;
  final int? points;

  const Teacher({
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
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
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
        roleId: json['role_id'] as int?,
        stageId: json['stage_id'] as dynamic,
        yearId: json['year_id'] as dynamic,
        points: json['points'] as int?,
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
    ];
  }
}
