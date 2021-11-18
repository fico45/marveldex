import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marveldex/custom_page_route.dart';
import 'package:marveldex/model/character_model.dart';
import 'package:marveldex/model/marvel_facade.dart';
import 'package:marveldex/screens/character_details_screen.dart';
import 'package:marveldex/widgets/display_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  MarvelFacade facade = MarvelFacade();
  Stream<Character> get _characterStream =>
      facade.characterStreamController.stream;

  @override
  void initState() {
    super.initState();
    facade.getCharacterList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Character>(
      stream: _characterStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No data!"));
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 3),
              itemCount: snapshot.data!.data.results.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                            page: CharacterDetailsScreen(
                                imageURL: snapshot.data!.data.results[index]
                                        .thumbnail.path +
                                    "." +
                                    snapshot.data!.data.results[index].thumbnail
                                        .extension,
                                name: snapshot.data!.data.results[index].name,
                                description: snapshot
                                    .data!.data.results[index].description,
                                comics: snapshot
                                    .data!.data.results[index].comics)));
                  },
                  child: DisplayItem(
                      imageURL:
                          snapshot.data!.data.results[index].thumbnail.path +
                              "." +
                              snapshot.data!.data.results[index].thumbnail
                                  .extension,
                      name: snapshot.data!.data.results[index].name),
                );
              });
        }
      },
    );

    /* return FutureBuilder<Character>(
      future: facade.getCharacterList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Text('There was an error.');
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 3),
              itemCount: snapshot.data!.data.results.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    //Navigator.of(context).push(route);
                  },
                  child: DisplayItem(
                      imageURL:
                          snapshot.data!.data.results[index].thumbnail.path +
                              "." +
                              snapshot.data!.data.results[index].thumbnail
                                  .extension,
                      name: snapshot.data!.data.results[index].name),
                );
              });
        }
      },
    ); */
  }
}
