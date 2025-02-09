import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/history_repository.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository historyRepository;
  HistoryCubit({required this.historyRepository}) : super(HistoryInitial());

  Future<void> getHistory() async {
    try {
      emit(HistoryLoading());

      final List<SongModel> history = await historyRepository.getLastTenSearchedSongs();

      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  Future<void> addSongToHistory(String songId) async {
    try {
      emit(HistoryLoading());
      await historyRepository.addSearch(songId);
      final List<SongModel> history = await historyRepository.getLastTenSearchedSongs();

      emit(HistoryLoaded(history));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }

  Future<void> removeSongToHistory(String historyId) async {
    try {
      if (state is HistoryLoaded) {
        final currentState = state as HistoryLoaded;
        await historyRepository.deleteSearch(historyId);
        final List<SongModel> updatedHistory =
            currentState.history.where((song) => song.historyId != historyId).toList();

        emit(HistoryLoaded(updatedHistory));
      }
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
