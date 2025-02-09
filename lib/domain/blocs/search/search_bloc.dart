import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SongRepository songRepository;
  SearchBloc({required this.songRepository}) : super(SearchLoading()) {
    on<OnSearchChange>(_onPerform);
  }

  void searchChange(String text) {
    add(OnSearchChange(text: text));
  }

  void _onPerform(
    OnSearchChange event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      if (event.text == '') {
        final List<SongModel> songs = await songRepository.getRecentlyPlayed();
        emit(SearchLoaded(songs: songs));
      } else {
        final List<SongModel> songs = await songRepository.searchSongs(event.text);
        emit(SearchLoaded(songs: songs));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
