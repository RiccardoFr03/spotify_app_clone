import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

part 'most_played_state.dart';

class MostPlayedCubit extends Cubit<MostPlayedState> {
  final SongRepository songRepository;
  MostPlayedCubit({required this.songRepository}) : super(MostPlayedInitial());

  Future<void> getMostPlayed(String userId) async {
    try {
      emit(MostPlayedLoading());
      final List<SongModel> songs = await songRepository.getNewsSongs();
      emit(
        MostPlayedLoaded(songs: songs),
      );
    } catch (e) {
      emit(MostPlayedError(message: e.toString()));
    }
  }
}
