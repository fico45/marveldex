import 'package:flutter/material.dart';
import 'package:marveldex/model/comic_model.dart';
import 'package:marveldex/model/marvel_facade.dart';
import 'package:marveldex/widgets/display_item.dart';

class ComicsScreen extends StatefulWidget {
  const ComicsScreen({Key? key}) : super(key: key);

  @override
  _ComicsScreenState createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  MarvelFacade facade = MarvelFacade();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Comic>(
      future: facade.getComicsList(),
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
                return DisplayItem(
                    imageURL: snapshot
                            .data!.data.results[index].thumbnail.path +
                        "." +
                        snapshot.data!.data.results[index].thumbnail.extension,
                    name: snapshot.data!.data.results[index].title);
              });
        }
      },
    );
  }
}
