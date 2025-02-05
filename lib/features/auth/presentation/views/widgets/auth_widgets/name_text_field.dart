import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: FormBuilderTextField(
            name: 'full_name',
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              //prefixIcon: Icon(Icons.person),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(4),
            ]),
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
