// import 'package:equatable/equatable.dart';

// import 'category.dart';
// import 'subject.dart';
// import 'year.dart';

// class Datum extends Equatable {
//   final Categoryy? category;
//   final List<Subject>? subjects;
//   final List<Year>? years;

//   const Datum({this.category, this.subjects, this.years});

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         category: json['category'] == null
//             ? null
//             : Categoryy.fromJson(json['category'] as Map<String, dynamic>),
//         subjects: (json['subjects'] as List<dynamic>?)
//             ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         years: (json['years'] as List<dynamic>?)
//             ?.map((e) => Year.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'category': category?.toJson(),
//         'subjects': subjects?.map((e) => e.toJson()).toList(),
//         'years': years?.map((e) => e.toJson()).toList(),
//       };

//   @override
//   List<Object?> get props => [category, subjects, years];
// }
