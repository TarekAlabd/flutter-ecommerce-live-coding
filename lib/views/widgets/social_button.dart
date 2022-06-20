import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
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
        child: Center(
          child: SvgPicture.asset(
            iconName,
            width: 40.0,
            height: 40.0,
          ),
        ),
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: ColorManager.kWhite,
          borderRadius: BorderRadius.circular(
            24.0,
          ),
        ),
      ),
    );
  }
}
