import 'package:equatable/equatable.dart';

class LockQuizz extends Equatable {
  final int? id;
  final String? name;
  final String? duration;
  final int? totalMark;
  final int? successMark;
  final int? public;
  final String? typeType;
  final int? typeId;
  final int? teacherId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const LockQuizz({
    this.id,
    this.name,
    this.duration,
    this.totalMark,
    this.successMark,
    this.public,
    this.typeType,
    this.typeId,
    this.teacherId,
    this.createdAt,
    this.updatedAt,
  });

  factory LockQuizz.fromJson(Map<String, dynamic> json) => LockQuizz(
        id: json['id'] as int?,
        name: json['name'] as String?,
        duration: json['duration'] as String?,
        totalMark: json['total_mark'] as int?,
        successMark: json['success_mark'] as int?,
        public: json['public'] as int?,
        typeType: json['type_type'] as String?,
        typeId: json['type_id'] as int?,
        teacherId: json['teacher_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration': duration,
        'total_mark': totalMark,
        'success_mark': successMark,
        'public': public,
        'type_type': typeType,
        'type_id': typeId,
        'teacher_id': teacherId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      duration,
      totalMark,
      successMark,
      public,
      typeType,
      typeId,
      teacherId,
      createdAt,
      updatedAt,
    ];
  }
}
