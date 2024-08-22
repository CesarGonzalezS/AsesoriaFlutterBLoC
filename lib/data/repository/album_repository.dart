import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/album_model.dart';

class AlbumRepository {
  final String baseUrl = 'https://eaeg2uqxz7.execute-api.us-east-2.amazonaws.com/Prod/';

  Future<Album> updateAlbum(Album album) async {
    final response = await http.put(
      Uri.parse('${baseUrl}update_albums/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(album.toJson()),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album');
    }
  }
}
