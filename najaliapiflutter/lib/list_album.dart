import 'package:flutter/material.dart';
import 'package:najaliapiflutter/controller/album_controller.dart';
import 'package:najaliapiflutter/album.dart';

class AlbumList extends StatefulWidget {
  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  final AlbumController albumController = AlbumController();
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = albumController.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des albums'),
      ),
      body: FutureBuilder<List<Album>>(
        future: futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Album> albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                Album album = albums[index];
                return ListTile(
                  title: Text('UserId: ${album.userId} - Title: ${album.title}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            // Error in fetching data
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // Data is still loading
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}