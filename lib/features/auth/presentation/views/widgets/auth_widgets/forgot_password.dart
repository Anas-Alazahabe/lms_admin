import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  final Function(bool) forgotPassword;
  const ForgotPassword({super.key, required this.forgotPassword});

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          // if (widget.formKey.currentState!.validate()) {
          //   BlocProvider.of<ResendEmailCubit>(context)
          //       .resendEmail(
          //           widget.formKey.currentState!.value['email']);
          // }
          widget.forgotPassword(true);
        },
        child: Text(
          'Forget Password',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              //fontStyle: FontStyle.italic,
            ),
          ),
        ));
  }
}
