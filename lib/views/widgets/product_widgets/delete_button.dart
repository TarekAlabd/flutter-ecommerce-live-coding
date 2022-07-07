import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteButton {
  static Widget build() {
    return const InkWell(
      child:  Icon(
        CupertinoIcons.xmark,
        color: Colors.grey,
      ),
    );
  }
}
