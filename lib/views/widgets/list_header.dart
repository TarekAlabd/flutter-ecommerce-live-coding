import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {

  final String title;
  final VoidCallback? onTap;
  final String description;

  const ListHeader({
    Key? key,
    required this.title,
    this.onTap,
    required this.description,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
