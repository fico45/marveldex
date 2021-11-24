import 'package:flutter/material.dart';
import 'package:marveldex/controller/marvel_facade.dart';
import 'package:marveldex/custom_page_route.dart';
import 'package:marveldex/model/character_model.dart';
import 'package:marveldex/screens/comic_details_screen.dart';
import 'package:marveldex/widgets/character_list_view_item.dart';
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
                    comics.returned == 0
                        ? const Text('No comics')
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: comics.items.length <= 2
                                ? comics.items.length
                                : 2,
                            itemBuilder: (context, index) {
                              return Consumer(
                                builder: (BuildContext context, WidgetRef ref,
                                    Widget? child) {
                                  return InkWell(
                                    onTap: () {
                                      //missing circular loading indicator while data is loading
                                      MarvelFacade()
                                          .getSingleComic(Uri.parse(comics
                                                  .items[index].resourceURI)
                                              .pathSegments
                                              .last)
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                            //works for the first element, but throws an asynchronous suspension on the 2nd :(
                                            page: ComicDetailsScreen(
                                                imageURL: value
                                                        .data
                                                        .results[index]
                                                        .thumbnail
                                                        .path +
                                                    '.' +
                                                    value.data.results[index]
                                                        .thumbnail.extension,
                                                title: value
                                                    .data.results[index].title,
                                                description: value.data
                                                    .results[index].description,
                                                issueNumber: value.data
                                                    .results[index].issueNumber,
                                                pageCount: value.data
                                                    .results[index].pageCount,
                                                characters: value.data
                                                    .results[index].characters),
                                          ),
                                        );
                                      });
                                    },
                                    child: CharacterListViewItem(
                                      name: comics.items[index].name,
                                      resourceURI:
                                          comics.items[index].resourceURI,
                                    ),
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
