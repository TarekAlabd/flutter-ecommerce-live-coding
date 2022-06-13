import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/constants/color_manager.dart';

class HomeHeader extends StatelessWidget {
  final String mainTitle, subTitle;
  final Function viewAll;
  const HomeHeader({
    Key? key,
    required this.mainTitle,
    required this.subTitle,
    required this.viewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        width: double.infinity,
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: const TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kBlack,
                  ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    color: ColorManager.kGrey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: size.height * 0.03,
              ),
              child: InkWell(
                onTap: () {
                  viewAll();
                },
                child: const Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    color: ColorManager.kBlack,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
