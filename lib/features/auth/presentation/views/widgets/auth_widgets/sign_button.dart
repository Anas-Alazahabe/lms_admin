import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin/core/cubits/shared_preferences_cubit/shared_preferences_cubit.dart';
import 'package:lms_admin/core/utils/app_router.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/utils/service_locator.dart';
import 'package:lms_admin/core/widgets/custom_button.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class SignButton extends StatefulWidget {
  // final VoidCallback onButtonPressed;
  final GlobalKey<FormBuilderState> formKey;
  // final Function(bool state) failedToLogState;
  // final Function(bool state) showCodeState;
  // final bool showCode;
  final bool isSignIn;
  // final bool failedToLog;
  // final String verificationCode;

  const SignButton({
    super.key,
    // required this.onButtonPressed,
    required this.formKey,
    required this.isSignIn,
    //required this.failedToLogState,
    // required this.failedToLog,
    //  required this.showCodeState,
    // required this.verificationCode,
    //  required this.showCode,
  });

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  final storageCubit = getIt<SharedPreferencesCubit>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            // widget.failedToLogState(true);

            // failedToLog = true;
            if (state.errMessage ==
                'The device token has already been taken.') {
              customToast(context, 'This account is already in use');
              // isSignIn = true;
              //   widget.onButtonPressed();
              // failedToLog = false;
              //  widget.failedToLogState(false);

              return;
            }
            if (state.errMessage == 'Invalid credentials') {
              // widget.showCodeState(true);
              // showCode = true;
              customToast(context, 'Invalid values');
              //  widget.onButtonPressed();
              //  widget.failedToLogState(false);

              //  failedToLog = false;
              return;
            }

            customToast(context, state.errMessage);
            //  widget.onButtonPressed();
          }
          if (state is AuthSuccess) {
            // failedToLog = false;
            // widget.failedToLogState(false);
            context.pushReplacement(AppRouter.kHomeView);

            // widget.onButtonPressed();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CustomLoading(),
            );
          }

          return CustomButton(
            onPressed: () {
              // if (widget.verificationCode.trim().length < 7 &&
              //  //   widget.showCode &&
              //     widget.isSignIn) {
              //   customToast(context, 'يجب ان يكون الرمز 7 محارف على الاقل');
              //   return;
              // }
              if (!widget.isSignIn &&
                  widget.formKey.currentState!.validate() &&
                  widget.formKey.currentState!.value['registerPassword'] !=
                      widget.formKey.currentState!
                          .value['confirmPasswordTextField']) {
                customToast(context,
                    'There is no match between the password and the confirmation password');
                return;
              }
              if (widget.isSignIn && widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                BlocProvider.of<AuthCubit>(context).signInWithUsernameAndToken(
                    email: widget.formKey.currentState!.value['loginEmail'],
                    password:
                        widget.formKey.currentState!.value['loginPassword']);
              } else {
                if (widget.formKey.currentState!.validate()) {
                  widget.formKey.currentState!.save();
                  BlocProvider.of<AuthCubit>(context).signUpWithNameAndPassword(
                      widget.formKey.currentState!.value['full_name'],
                      storageCubit.getId()!,
                      widget.formKey.currentState!.value['registerPassword']);
                }
              }
            },
            text: widget.isSignIn ? 'Login' : 'Create an account',
          );
        },
      ),
    );
  }
}
