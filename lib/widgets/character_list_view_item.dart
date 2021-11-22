import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marveldex/controller/providers.dart';
import 'package:marveldex/model/comic_model.dart';

class CharacterListViewItem extends StatelessWidget {
  const CharacterListViewItem({
    Key? key,
    required this.resourceURI,
    required this.name,
  }) : super(key: key);

  final String resourceURI;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFEFEF),
      child: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              //AsyncValue<Comic> comicProv = ref.watch(comicProvider);
              //int comicIndex = comicProv.asData!.value.data.results.indexWhere((element)=>element.resourceURI == resourceURI);

              return ListTile(
                leading:
                    /*cannot figure out how to get the image for the life of me, so
leaving it as is, until (IF) I figure it out.  */
                    /*Image(
                    image: NetworkImage(comic.asData!.value.data.results
                            .firstWhere(
                                (element) => element.resourceURI == resourceURI)
                            .thumbnail
                            .path +
                        '.' +
                        comic.asData!.value.data.results
                            .firstWhere(
                                (element) => element.resourceURI == resourceURI)
                            .thumbnail
                            .extension))*/
                    const Image(
                  image: AssetImage('lib/assets/no-image.png'),
                  height: 50,
                  width: 50,
                ),
                title: Text(name),
              );
            },
          ),
        ],
      ),
    );
  }
}
