import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailTextField extends StatelessWidget {
  final String emailKey;
  const EmailTextField({
    super.key,
    required this.emailKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: FormBuilderTextField(
            keyboardType: TextInputType.emailAddress,
            name: emailKey,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            // decoration: const InputDecoration(labelText: 'البريد الالكتروني'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
