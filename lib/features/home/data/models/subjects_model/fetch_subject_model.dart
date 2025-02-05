import 'package:lms_admin/features/home/data/models/subjects_model/category.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/fetch_data.dart';

class Fetsub {
  String? message;
  List<Data>? data;

  Fetsub({this.message, this.data});

  Fetsub.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

// class Data {
//   Category? category;
//   List<dynamic>? subjects;
//   List<Years>? years;

//   Data({this.category, this.subjects, this.years});

//   Data.fromJson(Map<String, dynamic> json) {
//     category = json["category"] == null ? null : Category.fromJson(json["category"]);
//     subjects = json["subjects"] ?? [];
//     years = json["years"] == null ? null : (json["years"] as List).map((e) => Years.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     if(category != null) {
//       _data["category"] = category?.toJson();
//     }
//     if(subjects != null) {
//       _data["subjects"] = subjects;
//     }
//     if(years != null) {
//       _data["years"] = years?.map((e) => e.toJson()).toList();
//     }
//     return _data;
//   }
// }

// class Years {
//   int? id; int? stageId;
//   String? year;

//   Years({this.id, this.year, this.stageId});

//   Years.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     year = json["year"];
//     stageId = json["stage_id"];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["year"] = year;
//     _data["stage_id"] = stageId;
//     return _data;
//   }
// }
