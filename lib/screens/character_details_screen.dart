import 'package:flutter/material.dart';
import 'package:marveldex/model/character_model.dart';
import 'package:marveldex/widgets/comic_list_view_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({
    Key? key,
    required this.imageURL,
    required this.name,
    required this.description,
    required this.comics,
  }) : super(key: key);

  final String imageURL;
  final String name;
  final String description;
  final Comics comics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(imageURL),
              ),
            ),
          ),
          Flexible(
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
                          'Name: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    )),
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
                            description == '' ? 'No description.' : description,
                            style: const TextStyle(fontSize: 16),
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
                          'List of comics:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // list of comics goes here
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            comics.items.length <= 2 ? comics.items.length : 2,
                        itemBuilder: (context, index) {
                          return Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              return ComicListViewItem(
                                title: comics.items[index].name,
                                resourceURI: comics.items[index].resourceURI,
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
