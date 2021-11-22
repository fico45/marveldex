import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marveldex/controller/providers.dart';
import 'package:marveldex/model/comic_model.dart';
import 'package:marveldex/widgets/display_item.dart';

import '../custom_page_route.dart';
import 'comic_details_screen.dart';

class ComicsScreen extends StatefulWidget {
  const ComicsScreen({Key? key}) : super(key: key);

  @override
  _ComicsScreenState createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      AsyncValue<Comic> comic = ref.watch(comicProvider);
      return comic.when(
          data: (comic) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 3),
              itemCount: comic.data.results.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                          page: ComicDetailsScreen(
                            imageURL: comic.data.results[index].thumbnail.path +
                                "." +
                                comic.data.results[index].thumbnail.extension,
                            title: comic.data.results[index].title,
                            description: comic.data.results[index].description,
                            issueNumber: comic.data.results[index].issueNumber,
                            pageCount: comic.data.results[index].pageCount,
                            characters: comic.data.results[index].characters,
                          ),
                        ));
                  },
                  child: DisplayItem(
                    imageURL: comic.data.results[index].thumbnail.path +
                        "." +
                        comic.data.results[index].thumbnail.extension,
                    name: comic.data.results[index].title,
                    isComic: true,
                  ),
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
