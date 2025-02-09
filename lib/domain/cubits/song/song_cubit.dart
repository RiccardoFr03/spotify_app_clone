import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

part 'song_state.dart';

class SongCubit extends Cubit<SongState> {
  final SongRepository songRepository;
  final List<SongModel> _history = [];
  int _currentIndex = -1;

  SongCubit({required this.songRepository}) : super(SongInitial());

  Future<void> getSongById(String id) async {
    try {
      emit(SongLoading());
      final song = await songRepository.getSongById(id);
      _addToHistory(song);
      emit(SongLoaded(response: song));
    } catch (e) {
      emit(SongError(message: e.toString()));
    }
  }

  Future<void> getRandomSong() async {
    try {
      final song = await songRepository.getRandomSong();
      _addToHistory(song);
      emit(SongLoaded(response: song));
    } catch (e) {
      emit(SongError(message: e.toString()));
    }
  }

  void _addToHistory(SongModel song) {
    if (_currentIndex < _history.length - 1) {
      _history.removeRange(_currentIndex + 1, _history.length);
    }
    _history.add(song);
    _currentIndex = _history.length - 1;
  }

  void back() {
    if (_currentIndex > 0) {
      _currentIndex--;
      final previousSong = _history[_currentIndex];
      emit(SongLoaded(response: previousSong));
    } else {}
  }
}
