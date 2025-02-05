import 'package:lms_admin/features/home/data/models/subjects_model/fetch_data.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';

class SubjectsModel {
  String? message;
  Subject? data;
  List<Data>? dataa;
  List<Subject>? subjectsss;
  Subject? singleSubject;
  SubjectsModel({this.message, this.data, this.subjectsss, this.dataa,this.singleSubject});

  SubjectsModel.multifromJson(Map<String, dynamic> json) {
    message = json["message"];
    dataa = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  factory SubjectsModel.fromSingleJson(Map<String, dynamic> json) {
    return SubjectsModel(
      message: json['message'] as String?,
      singleSubject:
          Subject.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  SubjectsModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = json["data"] == null ? null : Subject.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

// import 'package:equatable/equatable.dart';

// import 'datum.dart';

// class SubjectsModel extends Equatable {
// 	final String? message;
// 	final List<Datum>? data;

// 	const SubjectsModel({this.message, this.data});

// 	factory SubjectsModel.fromJson(Map<String, dynamic> json) => SubjectsModel(
// 				message: json['message'] as String?,
// 				data: (json['data'] as List<dynamic>?)
// 						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
// 						.toList(),
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'message': message,
// 				'data': data?.map((e) => e.toJson()).toList(),
// 			};

// 	@override
// 	List<Object?> get props => [message, data];
// }
