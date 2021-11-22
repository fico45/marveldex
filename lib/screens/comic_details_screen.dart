import 'package:flutter/material.dart';

import 'package:marveldex/model/comic_model.dart' as Characters;
import 'package:marveldex/model/comic_model.dart';
import 'package:marveldex/widgets/comic_list_view_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComicDetailsScreen extends StatelessWidget {
  const ComicDetailsScreen({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.description,
    required this.issueNumber,
    required this.pageCount,
    required this.characters,
  }) : super(key: key);

  final String imageURL;
  final String title;
  final String description;
  final int issueNumber;
  final int pageCount;
  final Characters.Characters characters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comic details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(imageURL),
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Title: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 2,
                              softWrap: true,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Description: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              description == ''
                                  ? 'No description.'
                                  : description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Page count: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            pageCount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Issue number: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            issueNumber.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            'List of characters:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // list of characters goes here
                      characters.returned == 0
                          ? const Text('No characters')
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: characters.items.length <= 2
                                  ? characters.items.length
                                  : 2,
                              itemBuilder: (context, index) {
                                return Consumer(
                                  builder: (BuildContext context, WidgetRef ref,
                                      Widget? child) {
                                    return ComicListViewItem(
                                      title: characters.items[index].name,
                                      resourceURI:
                                          characters.items[index].resourceURI,
                                    );
                                  },
                                );
                              }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
