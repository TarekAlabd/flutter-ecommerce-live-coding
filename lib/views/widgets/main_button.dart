import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final bool hasCircularBorder;
  final Widget? child;

  MainButton({
    super.key,
    this.text,
    this.onTap,
    this.hasCircularBorder = false,
    this.child,
  }) {
    assert(text != null || child != null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: hasCircularBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                )
              : null,
        ),
        child: text != null ? Text(
          text!,
        ) : child,
      ),
    );
  }
}
