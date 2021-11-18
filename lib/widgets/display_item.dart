import 'package:flutter/material.dart';

class DisplayItem extends StatelessWidget {
  const DisplayItem({
    Key? key,
    required this.imageURL,
    required this.name,
  }) : super(key: key);

  final String imageURL;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(imageURL),
            ),
          ),
          Text(
            name.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
