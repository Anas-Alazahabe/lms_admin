import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_admin/constants.dart';
import 'package:lms_admin/core/utils/functions/custom_toast.dart';
import 'package:lms_admin/core/widgets/custom_loading.dart';
import 'package:lms_admin/features/auth/presentation/manager/forgot_password_code_and_email_cubit/forgot_password_code_and_email_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/forgot_password_email_cubit/forgot_password_email_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/new_password_cubit/new_password_cubit.dart';
import 'package:lms_admin/features/auth/presentation/manager/verify_user_cubit/verify_user_cubit.dart';
import 'package:lms_admin/features/auth/presentation/views/widgets/auth_widgets/confirm_password_text_field.dart';
import 'package:lms_admin/features/auth/presentation/views/widgets/auth_widgets/password_text_field.dart';
import 'package:lms_admin/features/auth/presentation/views/widgets/auth_widgets/resend_email_item.dart';
import 'package:lms_admin/features/auth/presentation/views/widgets/auth_widgets/sign_button.dart';

import 'auth_widgets/email_text_field.dart';
import 'auth_widgets/forgot_password.dart';
import 'auth_widgets/name_text_field.dart';
import 'auth_widgets/otp_field.dart';

class AuthBody extends StatefulWidget {
  // final Function() onButtonPressed;
  // final Function(bool state) failedToLogState;
  // final bool failedToLog;

  const AuthBody({
    super.key,
    // required this.onButtonPressed,
    // required this.failedToLogState,
    // required this.failedToLog,
  });

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSignIn = true;
  bool forgotPassword = false;
  // bool showCode = false;
  bool userVerified = false;
  bool forgotPasswordEmailVerified = false;
  bool forgotPasswordCodeVerified = false;
  bool forgotPasswordDone = false;
  String signupCode = '';
  String forgotPasswordCode = '';
  String verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        //width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/logoIcon.png'),
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.38,
                    //width: 280,
                    //height: 280,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    kAppName,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xFF154957),
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        //fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                //height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color(0xFFFBFAFA),
                ),
                padding: const EdgeInsets.only(top: 100, right: 40),
                child: Column(
                  children: [
                    _buildLogo(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildAuthHeader(),
                    const SizedBox(
                      height: 28,
                    ),
                    FormBuilder(
                      key: _formKey,
                      onChanged: _onFormChanged,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: _buildAuthForm(_formKey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    if (!isSignIn) {
      return const Image(
        image: AssetImage('assets/images/activeIcon.png'),
        width: 100,
        height: 100,
      );
    } else if (forgotPassword) {
      return const Image(
        image: AssetImage('assets/images/resetIcon.png'),
        width: 100,
        height: 100,
      );
    } else {
      return const Image(
        image: AssetImage('assets/images/loginIcon.png'),
        width: 100,
        height: 100,
      );
    }
    // return Image(
    //   image: AssetImage('assets/images/loginIcon.png'),
    //   width: 100,
    //   height: 100,
    // );

    ////////////////

    // return Center(
    //   child: CircleAvatar(
    //     backgroundColor: Colors.transparent,
    //     radius: MediaQuery.of(context).size.width * 0.2,
    //     backgroundImage: const AssetImage(AssetsData.logo),
    //   ),
    // );
  }

  Widget _buildAuthHeader() {
    late String text;
    if (!isSignIn) {
      text = 'Active your Account';
    } else if (forgotPassword) {
      text = 'Reset Password';
    } else {
      text = 'Member Login';
    }
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: kTextCollor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthForm(formKey) {
    return Column(
      children: [
        if (!userVerified && !isSignIn) ...[
          _buildUserVerificationForm(formKey),
        ],
        if (userVerified && !isSignIn) ...[
          _buildUserDataForm(),
        ],

        if (isSignIn) ...[
          Column(
            children: [
              if (!forgotPassword) ...[
                const EmailTextField(emailKey: 'loginEmail'),
                const SizedBox(
                  height: 16,
                ),
                const PasswordTextField(pwKey: 'loginPassword'),
              ],

              /////////////////////////////////////////////
              if (forgotPassword &&
                  !forgotPasswordEmailVerified &&
                  !forgotPasswordCodeVerified)
                BlocConsumer<ForgotPasswordEmailCubit,
                    ForgotPasswordEmailState>(
                  listener: _onForgotEmail,
                  builder: (context, state) {
                    if (state is ForgotPasswordEmailLoading) {
                      return const CustomLoading();
                    }
                    return Column(
                      children: [
                        const EmailTextField(
                          emailKey: 'forgotEmail',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 60,
                          decoration: BoxDecoration(
                              color: kTextCollor,
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: emailForgotPassword,
                            child: Text(
                              'Next',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  //fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
          if (forgotPassword &&
              forgotPasswordEmailVerified &&
              !forgotPasswordCodeVerified)
            BlocConsumer<ForgotPasswordCodeAndEmailCubit,
                ForgotPasswordCodeAndEmailState>(
              listener: _onForgotEmailAndCode,
              builder: (context, state) {
                if (state is ForgotPasswordCodeAndEmailLoading) {
                  return const CustomLoading();
                }
                return Column(
                  children: [
                    OtpField(changeCode: _onForgotPasswordCodeSubmitter),
                    const SizedBox(
                      height: 15,
                    ),
                    ResendEmailItem(formKey: formKey),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 60,
                      decoration: BoxDecoration(
                          color: kTextCollor,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: _submitForgotPasswordCode,
                        child: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          if (forgotPassword &&
              forgotPasswordEmailVerified &&
              forgotPasswordCodeVerified)
            BlocConsumer<NewPasswordCubit, NewPasswordState>(
              listener: _onForgotPasswordDone,
              builder: (context, state) {
                if (state is NewPasswordLoading) {
                  return const CustomLoading();
                }
                return Column(
                  children: [
                    const PasswordTextField(pwKey: 'newPw'),
                    const ConfirmPasswordTextField(
                      pwKey: 'newPwConfirm',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 60,
                      decoration: BoxDecoration(
                          color: kTextCollor,
                          borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: _setPassword,
                        child: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],

        if ((userVerified || isSignIn) && !forgotPassword) ...[
          Column(
            children: [
              const SizedBox(
                height: 7,
              ),
              SignButton(
                formKey: _formKey,
                // onButtonPressed: widget.onButtonPressed,
                isSignIn: isSignIn,
              ),
            ],
          ),
        ],
        /////////////////////////////////////////////////////////////////////////////////////////

        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSignIn) ...[
                if (!forgotPassword) ...[
                  ForgotPassword(
                    forgotPassword: (value) {
                      setState(() {
                        forgotPassword = value;
                      });
                    },
                  ),
                  Text(
                    '/ ',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        //fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
              _buildSignInToggle(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserVerificationForm(formkey) {
    return BlocConsumer<VerifyUserCubit, VerifyUserState>(
      listener: _onUserVerified,
      builder: (context, state) {
        if (state is VerifyUserLoading) {
          return const CustomLoading();
        }
        return Column(
          children: [
            const EmailTextField(
              emailKey: 'verifyEmail',
            ),
            OtpField(changeCode: _onVerificationCodeSubmitted),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 60,
              decoration: BoxDecoration(
                  color: kTextCollor, borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: _verifyUser,
                child: Text(
                  'Next',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      //fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserDataForm() {
    return Column(
      children: [
        if (!isSignIn) ...[
          const NameTextField(),
          const PasswordTextField(pwKey: 'registerPassword'),
          const ConfirmPasswordTextField(
            pwKey: 'confirmPasswordTextField',
          ),
        ],
      ],
    );
  }

  Widget _buildSignInToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          !isSignIn ? 'Back to ' : '',

          //  'لديك حساب بالفعل؟',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              //fontStyle: FontStyle.italic,
            ),
          ),
        ),
        TextButton(
          onPressed: _toggleSignIn,
          child: Text(
            !isSignIn ? 'Login' : 'Active your Account',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                //fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onFormChanged() {
    _formKey.currentState!.save();
    debugPrint(_formKey.currentState!.value.toString());
  }

  void _onUserVerified(
    BuildContext context,
    VerifyUserState state,
  ) {
    if (state is VerifyUserFailure) {
      customToast(context, state.errMessage);
    }
    if (state is VerifyUserSuccess) {
      setState(() {
        userVerified = true;
      });
    }
  }

  void _onForgotEmail(
    BuildContext context,
    ForgotPasswordEmailState state,
  ) {
    if (state is ForgotPasswordEmailFailure) {
      customToast(context, state.errMessage);
    }
    if (state is ForgotPasswordEmailSuccess) {
      setState(() {
        forgotPasswordEmailVerified = true;
      });
    }
  }

  void _onForgotPasswordDone(
    BuildContext context,
    NewPasswordState state,
  ) {
    if (state is NewPasswordFailure) {
      customToast(context, state.errMessage);
    }
    if (state is NewPasswordSuccess) {
      customToast(context, 'Password has been changed');

      setState(() {
        isSignIn = true;
        forgotPassword = false;
        userVerified = false;
        forgotPasswordEmailVerified = false;
        forgotPasswordCodeVerified = false;
        forgotPasswordDone = false;
        signupCode = '';
        forgotPasswordCode = '';
        verificationCode = '';
      });
    }
  }

  void _onForgotEmailAndCode(
    BuildContext context,
    ForgotPasswordCodeAndEmailState state,
  ) {
    if (state is ForgotPasswordCodeAndEmailFailure) {
      customToast(context, state.errMessage);
    }
    if (state is ForgotPasswordCodeAndEmailSuccess) {
      setState(() {
        forgotPasswordCodeVerified = true;
      });
    }
  }

  void _verifyUser() {
    if (_formKey.currentState!.validate()) {
      if (signupCode.trim().length < 7) {
        customToast(context, 'The code must be at least 7 characters long');
        return;
      }
      BlocProvider.of<VerifyUserCubit>(context).verfiyUser(
        _formKey.currentState!.value['verifyEmail'],
        signupCode,
      );
    }
  }

  void _setPassword() {
    if (_formKey.currentState!.value['newPw'] !=
        _formKey.currentState!.value['newPwConfirm']) {
      customToast(context,
          'There is no match between the password and the confirmation password');
      return;
    }
    BlocProvider.of<NewPasswordCubit>(context).postNewPasswordAndEmail(
      _formKey.currentState!.value['forgotEmail'],
      _formKey.currentState!.value['newPwConfirm'],
    );
  }

  void _submitForgotPasswordCode() {
    if (forgotPasswordCode.trim().length < 7) {
      customToast(context, 'The code must be at least 7 characters long');
      return;
    }
    BlocProvider.of<ForgotPasswordCodeAndEmailCubit>(context)
        .postForgotPasswordCodeAndEmail(
      _formKey.currentState!.value['forgotEmail'],
      forgotPasswordCode,
    );
  }

  void emailForgotPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<ForgotPasswordEmailCubit>(context)
          .postForgotPasswordEmail(
        _formKey.currentState!.value['forgotEmail'],
      );
    }
  }

  void _onVerificationCodeSubmitted(String verificationCode) {
    signupCode = verificationCode;
  }

  void _onForgotPasswordCodeSubmitter(String verificationCode) {
    forgotPasswordCode = verificationCode;
  }

  void _toggleSignIn() {
    setState(() {
      forgotPasswordDone = false;
      forgotPassword = false;
      isSignIn = !isSignIn;
      _formKey.currentState!.reset();
    });
  }
}
