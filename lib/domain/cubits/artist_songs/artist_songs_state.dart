part of 'artist_songs_cubit.dart';

sealed class ArtistSongsState extends Equatable {
  const ArtistSongsState();

  @override
  List<Object?> get props => [];
}

final class ArtistSongsInitial extends ArtistSongsState {
  const ArtistSongsInitial();
}

final class ArtistSongsLoading extends ArtistSongsState {
  const ArtistSongsLoading();
}

final class ArtistSongsLoaded extends ArtistSongsState {
  final List<SongModel> songs;

  const ArtistSongsLoaded({required this.songs});

  @override
  List<Object> get props => [songs];
}

final class ArtistSongsError extends ArtistSongsState {
  final String message;

  const ArtistSongsError({required this.message});

  @override
  List<Object> get props => [message];
}
