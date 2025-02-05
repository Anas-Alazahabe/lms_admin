// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lms_admin/constants.dart';
// import 'package:lms_admin/core/utils/app_router.dart';
// import 'package:lms_admin/core/utils/assets.dart';
// import 'package:lms_admin/core/widgets/custom_loading.dart';
// import 'package:lms_admin/features/home/data/models/subjects_model/datum_subjects.dart';

// class SubjectsListViewItem extends StatelessWidget {
//   final DatumSubjects subject;
//   const SubjectsListViewItem({
//     super.key,
//     required this.screenHeight,
//     required this.subject,
//   });

//   final double screenHeight;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(6.0),
//       child: GestureDetector(
//         onTap: () {
//           if (subject.courses!.isEmpty) {
//             return;
//           }
//           subject.courses!.length == 1
//               ? context.push(AppRouter.kSubjectView, extra: {
//                   "datumSubjects": subject,
//                   "course_id": subject.courses!.first.id,
//                   "course_index": 1,
//                 })
//               : context.push(AppRouter.kCoursesView, extra: subject);
//         },
//         child: Card(
//           // elevation: 10,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   height: screenHeight * 0.13,
//                   width: screenHeight * 0.13,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: CachedNetworkImage(
//                       fit: BoxFit.fill,
//                       imageUrl: '$kBaseUrl/get_file/${subject.photo}',
//                       progressIndicatorBuilder: (context, url, progress) {
//                         return const CustomLoading();
//                       },
//                       errorWidget: (context, url, error) {
//                         return Image.asset(AssetsData.logo);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Flexible(
//                 flex: 6,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Text(
//                     subject.name!,
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//               ),
//               const Spacer(flex: 2),
//               const Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: Icon(Icons.arrow_forward_ios_rounded))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
