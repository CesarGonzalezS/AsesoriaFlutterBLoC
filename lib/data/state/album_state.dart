
import'../model/album_model.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumUpdated extends AlbumState {
  final Album album;

  AlbumUpdated(this.album);
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);
}
