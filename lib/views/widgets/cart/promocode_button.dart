import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PromocodeButton {
  static build(BuildContext context) {
    return SizedBox(
      height: 37.5,
      width: 37.5,
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
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
          child: const Icon(
            CupertinoIcons.arrow_right,
            color: Colors.white,
            size: 22,
          )),
    );
  }
}
