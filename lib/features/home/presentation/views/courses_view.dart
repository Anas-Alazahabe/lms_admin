// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lms_admin/core/utils/app_router.dart';
// import 'package:lms_admin/features/home/data/models/subjects_model/datum_subjects.dart';

// class CoursesView extends StatelessWidget {
//   final DatumSubjects subject;
//   const CoursesView({super.key, required this.subject});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('اختيار دورة'),
//         ),
//         body: ListView.builder(
//           physics: const BouncingScrollPhysics(),
//           itemCount: subject.courses!.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(4)),
//                     // border:  Border.all(color: Colors.green)
//                   ),
//                   child: ListTile(
//                     leading: const Icon(Icons.menu_book_rounded),
//                     title: Text('الدورة ${index + 1}'),
//                     onTap: () {
//                       context.push(AppRouter.kSubjectView, extra: {
//                         "datumSubjects": subject,
//                         "course_id": subject.courses![index].id,
//                         "course_index": index + 1
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
