import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordTextField extends StatefulWidget {
  final String pwKey;
  const PasswordTextField({super.key, required this.pwKey});

  @override
  PasswordTextFieldState createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: FormBuilderTextField(
            name: widget.pwKey,
            decoration: InputDecoration(
              labelText: 'Password',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
            ),
            obscureText: _isObscure,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'This field cannot be empty.'),
              FormBuilderValidators.minLength(8,
                  errorText: 'The password must contain at least 8 characters'),
              FormBuilderValidators.match(r'(?=.*?[A-Z])',
                  errorText:
                      'The password must contain at least one capital letter.'),
              FormBuilderValidators.match(r'(?=.*?[a-z])',
                  errorText:
                      'The password must contain at least one lowercase letter.'),
              FormBuilderValidators.match(r'(?=.*?[0-9])',
                  errorText: 'The password must contain at least a number.'),
            ]),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
