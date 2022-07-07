import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavButton {
  static build(BuildContext context, bool isFavMarked) {
    return Positioned(
        bottom: 0,        //alignment: Alignment.bottomRight,
        child: SizedBox(
          height: 52.5,
          width: 52.5,
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
                isFavMarked ? Icons.favorite : Icons.favorite_outline,
                color: !isFavMarked ? Colors.grey : Colors.red,
              )),
        ));
  }
}
