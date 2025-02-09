import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

part 'artist_songs_state.dart';

class ArtistSongsCubit extends Cubit<ArtistSongsState> {
  final SongRepository songRepository;
  ArtistSongsCubit({required this.songRepository}) : super(ArtistSongsInitial());

  Future<void> getArtistSongs(String name) async {
    try {
      emit(ArtistSongsLoading());

      final List<SongModel> songs = await songRepository.getArtistSongs(name);

      emit(ArtistSongsLoaded(songs: songs));
    } catch (e) {
      emit(ArtistSongsError(message: e.toString()));
    }
  }
}
