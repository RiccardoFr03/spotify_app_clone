import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';

class FavoriteCubit extends Cubit<bool?> {
  final SongRepository songRepository;

  FavoriteCubit({required this.songRepository}) : super(null);

  Future<void> favoriteButtonUpdated(String songId) async {
    try {
      final currentState = state ?? false;
      emit(!currentState);
      final isFavorite = await songRepository.addOrRemoveFavoriteSong(songId);
      emit(isFavorite);
    } catch (e) {
      emit(state);
      rethrow;
    }
  }
}
