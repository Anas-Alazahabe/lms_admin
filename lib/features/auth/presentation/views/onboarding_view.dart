import 'package:flutter/material.dart';
import 'package:lms_admin/core/utils/assets.dart';
import 'package:lms_admin/features/auth/presentation/views/widgets/auth.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool splash = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
          splash = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !splash
            ? Center(child: Image.asset(AssetsData.logo))
            : const AuthBody(
                // onButtonPressed: () {
                //   setState(() {
                //     if (!failedToLog) {
                //     }
                //   });
                // },
                // failedToLogState: (bool state) {
                //   failedToLog = state;
                // },
                // failedToLog: failedToLog,
                ),
      ),
    );
  }
}
