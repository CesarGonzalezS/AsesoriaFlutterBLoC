import 'package:bloc/bloc.dart';

import '../repository/album_repository.dart';
import '../model/album_model.dart';
import '../state/album_state.dart';



class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository albumRepository;

  AlbumCubit(this.albumRepository) : super(AlbumInitial());

  Future<void> updateAlbum(Album album) async {
    try {
      emit(AlbumLoading());
      final updatedAlbum = await albumRepository.updateAlbum(album);
      emit(AlbumUpdated(updatedAlbum));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }
}
