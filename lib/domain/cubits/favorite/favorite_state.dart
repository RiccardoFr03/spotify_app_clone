abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final bool isFavorite;

  FavoriteUpdated({required this.isFavorite});
}

class FavoriteError extends FavoriteState {}
