import 'package:flutter/material.dart';

import '../../../utilities/colors.dart';

class DarkButton extends StatelessWidget {
  final String label_;
  //final Icon icon_;
  final VoidCallback onTapAction;
  const DarkButton(
      {Key? key,
      required this.label_,
      //required this.icon_,
      required this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
      onPressed: onTapAction,
    //  icon: icon_,
      child: Text(
        label_,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
