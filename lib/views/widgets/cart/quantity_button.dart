
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuantityButton {
  static build(BuildContext context, bool isIncrease) {
    return SizedBox(
      height: 40.5,
      width: 40.5,
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Icon(
            isIncrease ? CupertinoIcons.plus : CupertinoIcons.minus,
            color: Colors.grey ,
          )),
    );
  }
}
