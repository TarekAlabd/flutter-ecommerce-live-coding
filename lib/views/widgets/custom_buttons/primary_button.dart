import 'package:flutter/material.dart';

import '../../../utilities/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label_;
  //final Icon icon_;
  final VoidCallback onTapAction;
  const PrimaryButton(
      {Key? key,
      required this.label_,
      //required this.icon_,
      required this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapAction,
      child: SizedBox(
        height:42,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius:  BorderRadius.all(
              Radius.circular(25),
            ),color:primaryColor 
          ),
          child: Center(
             
             
            child: Text(label_,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
