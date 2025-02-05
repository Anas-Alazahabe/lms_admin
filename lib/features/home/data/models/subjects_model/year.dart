class YearsContent {
  int? yearId;
  int? id;
  int? stageId;

  YearsContent({this.yearId, this.id, this.stageId});

  YearsContent.fetchfromJson(Map<String, dynamic> json) {
    id = json["id"];
    yearId = json["year_id"];
    stageId = json["stage_id"];
  }

  YearsContent.fromJson(Map<String, dynamic> json) {
    yearId = json["year_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["year_id"] = yearId;
    return _data;
  }
}

// import 'package:equatable/equatable.dart';

// class Year extends Equatable {
// 	final int? id;
// 	final String? year;
// 	final int? stageId;

// 	const Year({this.id, this.year, this.stageId});

// 	factory Year.fromJson(Map<String, dynamic> json) => Year(
// 				id: json['id'] as int?,
// 				year: json['year'] as String?,
// 				stageId: json['stage_id'] as int?,
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'id': id,
// 				'year': year,
// 				'stage_id': stageId,
// 			};

// 	@override
// 	List<Object?> get props => [id, year, stageId];
// }
