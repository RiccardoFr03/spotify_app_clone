part of 'most_played_cubit.dart';

sealed class MostPlayedState extends Equatable {
  const MostPlayedState();

  @override
  List<Object> get props => [];
}

final class MostPlayedLoading extends MostPlayedState {
  const MostPlayedLoading();
}

final class MostPlayedInitial extends MostPlayedState {
  const MostPlayedInitial();
}

final class MostPlayedLoaded extends MostPlayedState {
  final List<SongModel> songs;

  const MostPlayedLoaded({required this.songs});

  @override
  List<Object> get props => [songs];
}

final class MostPlayedError extends MostPlayedState {
  final String message;

  const MostPlayedError({required this.message});

  @override
  List<Object> get props => [message];
}
