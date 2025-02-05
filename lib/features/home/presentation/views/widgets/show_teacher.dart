import 'package:flutter/material.dart';
import 'package:lms_admin/core/utils/assets.dart';

class ShowTeacher extends StatelessWidget {
  const ShowTeacher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'مدرس المادة',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Spacer(),
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundImage: AssetImage(
                AssetsData.logo,
              ),
              backgroundColor: Colors.transparent,
              radius: 30,
            ),
            title: Text('الحضارة'),
            subtitle: Text('مدرس اللغة العربية'),
          ),
        ],
      ),
    );
  }
}
