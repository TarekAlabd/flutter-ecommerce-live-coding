import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utilities/enums.dart';

class DefaultToast {
  final String message;
  final ToastStates state;
  final Widget? actionWidget;

  const DefaultToast(
      {
      required this.message,
      required this.state,
      this.actionWidget,
      });

  void showToast() {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastState(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Color _chooseToastState(ToastStates state) {
    Color color;

    switch (state) {
      case ToastStates.success:
        color = Colors.green;
        break;
      case ToastStates.error:
        color = Colors.red;
        break;
      case ToastStates.warning:
        color = Colors.amber;
        break;
    }

    return color;
  }
}
