import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/auth/presentation/manager/resend_email_cubit/resend_email_cubit.dart';

class ResendEmailItem extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;

  const ResendEmailItem({super.key, required this.formKey});

  @override
  ResendEmailItemState createState() => ResendEmailItemState();
}

class ResendEmailItemState extends State<ResendEmailItem> {
  late Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResendEmailCubit, ResendEmailState>(
      listener: (context, state) {
        if (state is ResendEmailFailure) {
          customToast(context, state.errMessage);
        }
        if (state is ResendEmailSuccess) {
          _start = 60;
          startTimer();
        }
        if (state is ResendEmailFailure) {
          _start = 60;
          startTimer();
        }
      },
      builder: (context, state) {
        if (state is ResendEmailLoading) {
          return const CustomLoading();
        }
        return _start > 0
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('$_start'),
              )
            : Row(
                children: [
                  const Spacer(),
                  const Text('لم تستلم الرمز؟'),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        BlocProvider.of<ResendEmailCubit>(context).resendEmail(
                            widget.formKey.currentState!.value['forgotEmail']);
                      },
                      child: const Text(
                        'إعادة ارسال',
                        style: TextStyle(color: kAppColor),
                      )),
                  const Spacer(),
                ],
              );
      },
    );
  }
}
