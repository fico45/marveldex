import 'package:flutter/material.dart';

class DisplayItem extends StatelessWidget {
  const DisplayItem({
    Key? key,
    required this.imageURL,
    required this.name,
    required this.isComic,
  }) : super(key: key);

  final String imageURL;
  final String name;
  final bool isComic;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(imageURL),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Flexible(
            child: Text(
              name.toUpperCase(),
              maxLines: isComic == false ? 2 : 1,
              softWrap: true,
              overflow: isComic == false
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
