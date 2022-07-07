import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/colors.dart';

class DiscountSpan {
  static Widget build(
      BuildContext context, bool hasDiscount, int? discountVal) {
    final Color color_ = hasDiscount ? primaryColor : Colors.black;
    final String text_ = hasDiscount ? '- $discountVal%' : 'new';
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 33,
          width: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: color_,
            ),
            child: Center(
              child: Text(text_,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
