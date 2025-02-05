import 'package:equatable/equatable.dart';

import 'ad.dart';

class AdsModel extends Equatable {
  final List<Ad>? message;
  final Ad? singleAd;

  const AdsModel({this.message, this.singleAd});

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        message: (json['message'] as List<dynamic>?)
            ?.map((e) => Ad.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  factory AdsModel.fromSingleJson(Map<String, dynamic> json) => AdsModel(
        singleAd: Ad.fromJson(json['ad'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [message];
}
