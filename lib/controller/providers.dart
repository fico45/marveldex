import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marveldex/model/character_model.dart';
import 'package:marveldex/model/comic_model.dart';

import 'marvel_facade.dart';

final characterProvider = FutureProvider<Character>((ref) {
  return Future.value(MarvelFacade().getCharacterList());
});

final comicProvider = FutureProvider<Comic>((ref) {
  return Future.value(MarvelFacade().getComicsList());
});
