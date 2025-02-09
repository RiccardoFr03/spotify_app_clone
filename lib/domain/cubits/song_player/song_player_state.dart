abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final DateTime time;

  SongPlayerLoaded({required this.time});
}

class SongPlayerError extends SongPlayerState {}

class SongPlayerCanExit extends SongPlayerState {}
