import 'dart:convert';

import 'package:najaliapiflutter/album.dart';
import 'package:http/http.dart' as http;

class AlbumController {

  Future<List<Album>> fetchAlbums()async{
    final response = 
     await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      List<dynamic> jsonAlbums = json.decode(response.body);
      List<Album> albums = jsonAlbums.map((json) => Album.fromJson(json)).toList();

      return albums;

    }else{
      throw Exception('Erreur de chargement');
    }

  }  
}