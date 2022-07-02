import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
    required this.iconName,
    required this.onPress,
  }) : super(key: key);
  final String iconName;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconName,
            width: 40.0,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
