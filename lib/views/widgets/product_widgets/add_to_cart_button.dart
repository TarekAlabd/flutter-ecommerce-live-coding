import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/colors.dart';

class AddToCartButton {
  static build(BuildContext context) {
    return Positioned(
        bottom: 0, //alignment: Alignment.bottomRight,
        child: SizedBox(
          height: 52.5,
          width: 52.5,
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child:const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              )),
        ));
  }
}
