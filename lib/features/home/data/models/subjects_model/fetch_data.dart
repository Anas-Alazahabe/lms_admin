import 'package:lms_admin/features/home/data/models/subjects_model/category.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/fetch_subject_model.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/subject.dart';
import 'package:lms_admin/features/home/data/models/subjects_model/year.dart';

class Data {
  Category? category;
  // List<dynamic>? subjects;
  List<Subject>? subjects;
  
  List<YearsContent>? years;

  Data({this.category, this.subjects, this.years});

  Data.fromJson(Map<String, dynamic> json) {
    category =
        json["category"] == null ? null : Category.fromJson(json["category"]);
    subjects = json["subjects"] == null
        ? null
        : (json["subjects"] as List).map((e) => Subject.fromJson(e)).toList();
    years = json["years"] == null
        ? null
        : (json["years"] as List).map((e) => YearsContent.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (category != null) {
      _data["category"] = category?.toJson();
    }
    if (subjects != null) {
      _data["subjects"] = subjects;
    }
    if (years != null) {
      _data["years"] = years?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}
