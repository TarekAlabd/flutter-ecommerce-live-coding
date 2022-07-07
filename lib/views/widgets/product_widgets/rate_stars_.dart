import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RateStars {
   static Widget build(int rate_val,BuildContext context) {
    const int totalRate = 5;
    List<Widget> _starsView = [];
    for (int i = 1; i <= totalRate; i++) {
       
      _starsView.add(
        Icon(
           rate_val >= i ? Icons.star: Icons.star_border_outlined,
          color: rate_val >= i ? Colors.yellow[700]:Colors.grey,
        ),
      );
    }



    
    _starsView.add(Text('($rate_val)',style: const TextStyle(color: Colors.grey),));
    return Row(children: _starsView);
  }
}