import 'package:flutter/material.dart';

 
class WhiteImagButton extends StatelessWidget {
 // final String label_;
  final String imageUrl_;
  final VoidCallback onTapAction;
  const WhiteImagButton(
      {Key? key,
      //required this.label_,
      required this.imageUrl_,
      required this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onTapAction,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 20,
          child: Image.network(imageUrl_),
        ),
      ),
      // icon: const Icon(Icons.social_distance),
      //label: Text(''),
    );
  }
}
