import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/lesson.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit_data.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/unit_new_lesson_item.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class UnitListViewItem extends StatefulWidget {
  final UnitData unit;
  final String subjectName;
  final String subjectId;
  const UnitListViewItem({
    super.key,
    required this.unit,
    required this.subjectName,
    required this.subjectId,
  });

  @override
  State<UnitListViewItem> createState() => _UnitListViewItemState();
}

class _UnitListViewItemState extends State<UnitListViewItem> {
  late List<Lesson> unitsLesson;

  @override
  void initState() {
    unitsLesson = widget.unit.lessons!;
    super.initState();
  }

  SampleItem? selectedMenu;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Column(
          // leading: ClipRRect(
          //   child: SizedBox(

          //     width: 100,
          //     child: CachedNetworkImage(
          //       fit: BoxFit.cover,
          //       imageUrl: '$kBaseUrlAsset/images/${unit.photo}',
          //       progressIndicatorBuilder: (context, url, progress) {
          //         return const CustomLoading();
          //       },
          //       errorWidget: (context, url, error) {
          //         return Image.asset(AssetsData.logo);
          //       },
          //     ),
          //   ),
          // ),

          children: <Widget>[
            ListTile(
              title: Text(widget.unit.name!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              // subtitle: Text('data'),
              trailing: Container(
                width: 80,
                child: Row(
                  children: [
                    MenuAnchor(
                      builder: (BuildContext context, MenuController controller,
                          Widget? child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(Icons.more_vert),
                          tooltip: 'Show menu',
                        );
                      },
                      // alignmentOffset: Offset.fromDirection(BorderSide.strokeAlignCenter),
                      menuChildren: [
                        MenuItemButton(
                          onPressed: () {
                            // Handle edit action
                            setState(() => selectedMenu = SampleItem.itemOne);
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            // Handle delete action
                            setState(() => selectedMenu = SampleItem.itemTwo);
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.delete),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Column(
                children: [
                  ...unitsLesson
                      .map((lesson) => InkWell(
                            onTap: () {
                              context.push(AppRouter.kLessonView, extra: {
                                'lesson': lesson,
                                'subjectName': widget.subjectName,
                                'unitName': widget.unit.name,
                                'subject_id': widget.subjectId
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              height: 55,
                              decoration: BoxDecoration(
                                  // color: Colors.grey,
                                  ),
                              child: Card(
                                color: Colors.grey[200],
                                elevation: 2,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(Icons.book,
                                        size: 20, color: Colors.blue),
                                    SizedBox(width: 10),
                                    Text(lesson.name!,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  UnitNewLessonItem(
                      onAdd: (lesson) {
                        setState(() {
                          unitsLesson.add(lesson);
                        });
                      },
                      unitId: widget.unit.id!),
                ],
              ),
          ]),
    );
  }
}
