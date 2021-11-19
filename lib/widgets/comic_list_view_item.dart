import 'package:flutter/material.dart';

class ComicListViewItem extends StatelessWidget {
  const ComicListViewItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  /* TODO: implement state management so the cover images can be used, so not
  to call the API for each cover image*/

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFEFEF),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.album),
            title: Text(title),
          )
        ],
      ),
    );
  }
}
