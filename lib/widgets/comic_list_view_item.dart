import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marveldex/controller/marvel_facade.dart';

class ComicListViewItem extends StatelessWidget {
  const ComicListViewItem({
    Key? key,
    required this.resourceURI,
    required this.title,
  }) : super(key: key);

  final String resourceURI;
  final String title;

  Future<String> getImageURL() async {
    final uri = Uri.parse(resourceURI);
    Future<String> imageURL =
        MarvelFacade().getCharacterImage(uri.pathSegments.last);

    return imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFEFEF),
      child: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return ListTile(
                leading: FutureBuilder(
                  future: getImageURL(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const CircularProgressIndicator()
                        : Image(
                            image: NetworkImage(snapshot.data.toString()),
                            height: 50,
                            width: 50,
                          );
                  },
                ),
                title: Text(title),
              );
            },
          ),
        ],
      ),
    );
  }
}
