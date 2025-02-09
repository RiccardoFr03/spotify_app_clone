import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/artist_repository.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/models/artist_model.dart';
import 'package:spotify_clone/domain/models/home_data_model.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

part 'home_data_state.dart';

class HomeDataCubit extends Cubit<HomeDataState> {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  HomeDataCubit({required this.songRepository, required this.artistRepository}) : super(HomeDataInitial());

  Future<void> getHomeData() async {
    try {
      emit(HomeDataLoading());

      final List<dynamic> results = await Future.wait([
        artistRepository.getArtists(),
        songRepository.getNewsSongs(),
        songRepository.getRecentlyPlayed(),
      ]);

      List<ArtistModel> artists = results[0] as List<ArtistModel>;
      List<SongModel> playList = results[1] as List<SongModel>;
      List<SongModel> recent = results[2] as List<SongModel>;

      HomeDataModel homeData = HomeDataModel(
        artists: artists,
        playList: playList,
        recent: recent,
      );

      emit(HomeDataLoaded(response: homeData));
    } catch (e) {
      emit(HomeDataError(message: e.toString()));
    }
  }

  void updateFavoriteSong(String songId, bool isFavorite) {
    if (state is HomeDataLoaded) {
      try {
        final currentState = state as HomeDataLoaded;
        bool songFound = false;
        List<SongModel> updateList(List<SongModel> list) {
          bool foundInList = false;
          final updated = list.map((song) {
            if (song.songId == songId) {
              foundInList = true;
              return song.copyWith(isFavorite: isFavorite);
            }
            return song;
          }).toList();
          if (foundInList) songFound = true;
          return updated;
        }

        final updatedPlaylist = updateList(currentState.response.playList);
        final updatedRecent = updateList(currentState.response.playList);
        if (!songFound) {
          return;
        }
        emit(HomeDataLoaded(
          response: HomeDataModel(
            artists: currentState.response.artists,
            playList: updatedPlaylist,
            recent: updatedRecent,
          ),
        ));
      } catch (e) {
        return;
      }
    }
  }
}
