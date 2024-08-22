class Artist {
  final int artistId;
  final String name;
  final String genre;
  final String? bio;

  Artist({
    required this.artistId,
    required this.name,
    required this.genre,
    this.bio,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artist_id'],
      name: json['name'],
      genre: json['genre'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artist_id': artistId,
      'name': name,
      'genre': genre,
      'bio': bio,
    };
  }
}
