import 'package:flutter/material.dart';
import 'package:marveldex/custom_page_route.dart';
import 'package:marveldex/model/character_model.dart';
import 'package:marveldex/screens/character_details_screen.dart';
import 'package:marveldex/widgets/display_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marveldex/controller/providers.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      AsyncValue<Character> character = ref.watch(characterProvider);
      return character.when(
          data: (character) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 3),
              itemCount: character.data.results.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                            page: CharacterDetailsScreen(
                                imageURL: character
                                        .data.results[index].thumbnail.path +
                                    "." +
                                    character.data.results[index].thumbnail
                                        .extension,
                                name: character.data.results[index].name,
                                description:
                                    character.data.results[index].description,
                                comics: character.data.results[index].comics)));
                  },
                  child: DisplayItem(
                      imageURL: character.data.results[index].thumbnail.path +
                          "." +
                          character.data.results[index].thumbnail.extension,
                      name: character.data.results[index].name),
                );
              }),
          error: (e, stackTrace) => const Center(
                child: Text('There was an error.'),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ));
    });
  }
}
