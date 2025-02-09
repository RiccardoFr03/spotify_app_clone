import 'package:equatable/equatable.dart';
import 'package:spotify_clone/domain/models/artist_model.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

class HomeDataModel extends Equatable {
  final List<ArtistModel> artists;
  final List<SongModel> playList;
  final List<SongModel> recent;

  const HomeDataModel({required this.artists, required this.playList, required this.recent});

  @override
  List<Object?> get props => [artists, playList, recent];
}
