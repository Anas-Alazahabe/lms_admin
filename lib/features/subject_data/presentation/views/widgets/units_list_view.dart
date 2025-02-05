import 'package:flutter/material.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/features/subject_data/data/models/units_model/unit.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/unit_list_view_item.dart';
import 'package:lms_admin/features/subject_data/presentation/views/widgets/unit_list_view_new_item.dart';

class UnitsListView extends StatefulWidget {
  final String subjectId;
  final Unitt units;
  final String subjectName;
  const UnitsListView({
    super.key,
    required this.units,
    required this.subjectName,
    required this.subjectId,
  });

  @override
  State<UnitsListView> createState() => _UnitsListViewState();
}

class _UnitsListViewState extends State<UnitsListView> {
  late Unitt allUnits;
  @override
  void initState() {
    allUnits = widget.units;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allUnits.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return allUnits.data!.isEmpty
                ? const Text('لا يوجد وحدات')
                : UnitListViewItem(
                    subjectId: widget.subjectId,
                    unit: allUnits.data![index],
                    subjectName: widget.subjectName,
                  );
          },
        ),
        UnitListViewNewItem(
          subjectId: widget.subjectId,
          onAdd: (unit) {
            setState(() {
              allUnits.data!.add(unit);
            });
          },
        )
      ],
    );
  }
}
