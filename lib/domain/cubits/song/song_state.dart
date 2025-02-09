part of 'song_cubit.dart';

sealed class SongState extends Equatable {
  const SongState();

  @override
  List<Object?> get props => [];
}

final class SongInitial extends SongState {
  const SongInitial();
}

final class SongLoading extends SongState {
  const SongLoading();
}

final class SongLoaded extends SongState {
  final SongModel response;
  const SongLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

final class SongError extends SongState {
  final String message;

  const SongError({required this.message});

  @override
  List<Object> get props => [message];
}
