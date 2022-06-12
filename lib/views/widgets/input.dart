import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Input extends StatelessWidget {
  final String name;
  final String placeholder;
  final String label;
  final TextInputType textInputType;
  final bool isPassword;
  final bool isReadOnly;
  final String passwordCharacter;
  final Function(String?) onChange;
  final String? Function(String?) onValidate;
  final String initialValue;
  final Color iconColor;
  const Input({
    Key? key,
    required this.name,
    required this.placeholder,
    required this.label,
    required this.onChange,
    required this.onValidate,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.passwordCharacter = '*',
    this.initialValue = '',
    this.iconColor = Colors.grey,
    this.isReadOnly = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      enabled: isReadOnly,
      initialValue: initialValue,
      onChanged: onChange,
      validator: onValidate,
      name: name,
      style: TextStyle(
        color: isReadOnly ? ColorManager.kBlack : ColorManager.kGrey,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.kWhite,
        hintText: placeholder,
        labelText: label,
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
      obscuringCharacter: passwordCharacter,
    );
  }
}
