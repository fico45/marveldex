import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:marveldex/model/character_model.dart';

import '../model/comic_model.dart';

class MarvelFacade {
  final String privateKey = "8dde3100807cd31a9c94c1082f6c982f45e8ab6a";
  final String publicKey = "3a7652210333d97b63858e15edbfd10d";

  //returns characters from an API (only 100 of them as cannot fetch more)
  Future<Character> getCharacterList() async {
    //Get the MD5 Hash
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);

    //Assemble the URL
    String url =
        "https://gateway.marvel.com:443/v1/public/characters?limit=100&apikey=$publicKey&ts=$timeStamp&hash=$hash";

    //Call out to Marvel
    http.Response response = await http.get(Uri.parse(url));
    //Response -> String / json -> deserialize
    Character character = Character.fromJson(jsonDecode(response.body));
    return character;
  }

  //called when populating characters in comic details screen
  Future<String> getCharacterImage(String characterID) async {
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);
    String url =
        "https://gateway.marvel.com:443/v1/public/characters/$characterID?apikey=$publicKey&ts=$timeStamp&hash=$hash";
    http.Response response = await http.get(Uri.parse(url));
    Character character = Character.fromJson(jsonDecode(response.body));
    String imageURL = character.data.results[0].thumbnail.path +
        '.' +
        character.data.results[0].thumbnail.extension;
    return imageURL;
  }

  //gets a single character object
  Future<Character> getSingleCharacter(String characterID) async {
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);
    String url =
        "https://gateway.marvel.com:443/v1/public/characters/$characterID?apikey=$publicKey&ts=$timeStamp&hash=$hash";
    http.Response response = await http.get(Uri.parse(url));
    Character character = Character.fromJson(jsonDecode(response.body));
    return character;
  }

  //returns comics from an API (only 100 of them as cannot fetch more)
  Future<Comic> getComicsList() async {
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);
    String url =
        "https://gateway.marvel.com:443/v1/public/comics?limit=100&apikey=$publicKey&ts=$timeStamp&hash=$hash";

    http.Response response = await http.get(Uri.parse(url));
    Comic comic = Comic.fromJson(jsonDecode(response.body));

    return comic;
  }

  //called when populating comics in character details screen
  Future<String> getComicImage(String comicID) async {
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);

    String url =
        "https://gateway.marvel.com:443/v1/public/comics/$comicID?apikey=$publicKey&ts=$timeStamp&hash=$hash";
    http.Response response = await http.get(Uri.parse(url));
    Comic comic = Comic.fromJson(jsonDecode(response.body));
    String imageURL = comic.data.results[0].thumbnail.path +
        '.' +
        comic.data.results[0].thumbnail.extension;
    return imageURL;
  }

  //gets a single comic object
  Future<Comic> getSingleComic(String comicID) async {
    var timeStamp = DateTime.now().toString();
    var hash = createHash(timeStamp);
    String url =
        "https://gateway.marvel.com:443/v1/public/comics/$comicID?apikey=$publicKey&ts=$timeStamp&hash=$hash";
    http.Response response = await http.get(Uri.parse(url));
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
