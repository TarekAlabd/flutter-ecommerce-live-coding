import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final VoidCallback? addToFavorites;
  bool isFavorite;
  FavoriteButton({
    Key? key,
    required this.addToFavorites,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
            spreadRadius: 2,
          )
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 20.0,
        child: InkWell(
          onTap: addToFavorites,
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_outline,
            size: 20.0,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
