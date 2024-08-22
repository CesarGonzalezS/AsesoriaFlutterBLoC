import 'package:bloc/bloc.dart';

import '../repository/artist_repository.dart';
import '../model/artist_model.dart';
import '../state/artist_state.dart';


class ArtistCubit extends Cubit<ArtistState> {
  final ArtistRepository artistRepository;

  ArtistCubit(this.artistRepository) : super(ArtistInitial());

  Future<void> createArtist(Artist artist) async {
    try {
      emit(ArtistLoading());
      final newArtist = await artistRepository.createArtist(artist);
      emit(ArtistCreated(newArtist));
    } catch (e) {
      emit(ArtistError(e.toString()));
    }
  }
}
