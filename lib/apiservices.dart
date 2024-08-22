import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:examen1/data/model/artist_model.dart';
import 'package:examen1/data/model/album_model.dart';



class ApiServices {
  final String updateAlbumsUrl = 'https://eaeg2uqxz7.execute-api.us-east-2.amazonaws.com/Prod/update_albums/';
  final String createArtistUrl = 'https://eaeg2uqxz7.execute-api.us-east-2.amazonaws.com/Prod/create_artis/';

  // Crear un artista
  Future<Artist> createArtist(Artist artist) async {
    final response = await http.post(
      Uri.parse(createArtistUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(artist.toJson()),
    );

    if (response.statusCode == 200) {
      return Artist.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create artist');
    }
  }

  // Actualizar un álbum
  Future<Album> updateAlbum(Album album) async {
    final response = await http.put(
      Uri.parse(updateAlbumsUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(album.toJson()),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album');
    }
  }

  // Otros métodos CRUD para Artistas y Álbumes pueden ir aquí...
}
