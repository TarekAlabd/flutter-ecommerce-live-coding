import 'package:flutter/material.dart';

import '../../../utilities/colors.dart';

class PrimaryIconButton extends StatelessWidget {
  final String label_;
  final Icon icon_;
  final VoidCallback onTapAction;
  const PrimaryIconButton(
      {Key? key,
      required this.label_,
      required this.icon_,
      required this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
      onPressed: onTapAction,
      icon: icon_,
      label: Text(
        label_,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
