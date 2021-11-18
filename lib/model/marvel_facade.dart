import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:marveldex/model/character_model.dart';

import 'comic_model.dart';

class MarvelFacade {
  final StreamController<Character> characterStreamController =
      StreamController<Character>();

  final String privateKey = "8dde3100807cd31a9c94c1082f6c982f45e8ab6a";
  final String publicKey = "3a7652210333d97b63858e15edbfd10d";

  Future<void> getCharacterList() async {
    //Get the MD5 Hash
    print("CHARACTERS CALLED!!");
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);

    //Assemble the URL
    String url =
        "https://gateway.marvel.com:443/v1/public/characters?limit=100&apikey=$publicKey&ts=$timeStamp&hash=$hash";

    //Call out to Marvel
    http.Response response = await http.get(Uri.parse(url));
    //Response -> String / json -> deserialize
    Character character = Character.fromJson(jsonDecode(response.body));
    print(response.body);
    characterStreamController.sink.add(character);
  }

  Future<Comic> getComicsList() async {
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);

    print("COMICS CALLED!!!");

    String url =
        "https://gateway.marvel.com:443/v1/public/comics?limit=100&apikey=$publicKey&ts=$timeStamp&hash=$hash";

    http.Response response = await http.get(Uri.parse(url));
    print(response.body);
    Comic comic = Comic.fromJson(jsonDecode(response.body));

    return comic;
  }

  String createHash(String timeStamp) {
    var toBeHashed = timeStamp + privateKey + publicKey;
    var hashedMessage = generateMD5(toBeHashed);
    return hashedMessage;
  }

  String generateMD5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
