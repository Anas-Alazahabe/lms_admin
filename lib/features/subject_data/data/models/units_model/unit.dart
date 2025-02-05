import 'package:equatable/equatable.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/file.dart';

import 'unit_data.dart';

class Unitt extends Equatable {
  final String? message;
  final List<UnitData>? data;

  final UnitData? singleData;
  final bool? isSubscription;

  const Unitt({this.message, this.data, this.singleData, this.isSubscription});

  factory Unitt.fromJson(Map<String, dynamic> json) => Unitt(
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => UnitData.fromJson(e as Map<String, dynamic>))
            .toList(),
        isSubscription: json['isSubscription'] as bool?,
  
      );

  factory Unitt.fromSingleJson(Map<String, dynamic> json) {
    return Unitt(
      message: json['message'] as String?,
      singleData: UnitData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [message, data];
}
