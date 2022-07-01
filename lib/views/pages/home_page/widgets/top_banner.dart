import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';
import 'package:flutter_ecommerce/utilities/constants/image_manager.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.network(
          ImageManager.topBannerHomePageAsset,
          width: double.infinity,
          height: size.height * 0.3,
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: 0.2,
          child: Container(
            width: double.infinity,
            height: size.height * 0.3,
            color: ColorManager.kBlack,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Text(
            'Street Clothes',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: ColorManager.kWhite,
            ),
          ),
        ),
      ],
    );
  }
}
