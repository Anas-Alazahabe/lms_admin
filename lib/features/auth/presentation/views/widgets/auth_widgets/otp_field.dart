import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpField extends StatelessWidget {
  final Function(String code) changeCode;
  const OtpField({
    super.key,
    required this.changeCode,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: OtpTextField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          numberOfFields: 7,
          borderWidth: 2,
          keyboardType: TextInputType.text,
          borderColor: const Color.fromARGB(255, 0, 0, 0),
          showFieldAsBox: true,
          autoFocus: true,
          onSubmit: (String verificationCode) {
            changeCode(verificationCode);
            //   verificationCodee = verificationCode;
          },
        ),
      ),
    );
  }
}
