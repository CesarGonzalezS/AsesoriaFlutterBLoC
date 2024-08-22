import'../model/artist_model.dart';
abstract class ArtistState {}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistCreated extends ArtistState {
  final Artist artist;

  ArtistCreated(this.artist);
}

class ArtistError extends ArtistState {
  final String message;

  ArtistError(this.message);
}
