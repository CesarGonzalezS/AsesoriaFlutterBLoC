import 'package:http/http.dart' as http;
import 'dart:convert';


import '../model/artist_model.dart';

class ArtistRepository {
  final String baseUrl = 'https://eaeg2uqxz7.execute-api.us-east-2.amazonaws.com/Prod/';

  Future<Artist> createArtist(Artist artist) async {
    final response = await http.post(
      Uri.parse('${baseUrl}create_artis/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(artist.toJson()),
    );

    if (response.statusCode == 200) {
      return Artist.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create artist');
    }
  }
}
