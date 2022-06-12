import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPress;
  const Button({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //style: ElevatedButtonThemeData(style: ),
      onPressed: () {
        onPress();
      },
      child: SizedBox(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: ColorManager.kWhite,
              fontSize: 14.0,
            ),
          ),
        ),
        width: double.infinity,
        height: 55.0,

        // decoration: BoxDecoration(
        //   color: ColorManager.kRed,
        //   borderRadius: BorderRadius.circular(
        //     25.0,
        //   ),
        // ),
      ),
    );
  }
}
