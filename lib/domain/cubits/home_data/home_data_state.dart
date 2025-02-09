part of 'home_data_cubit.dart';

sealed class HomeDataState extends Equatable {
  const HomeDataState();

  @override
  List<Object?> get props => [];
}

final class HomeDataInitial extends HomeDataState {
  const HomeDataInitial();
}

final class HomeDataLoading extends HomeDataState {
  const HomeDataLoading();
}

final class HomeDataLoaded extends HomeDataState {
  final HomeDataModel response;
  const HomeDataLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

final class HomeDataError extends HomeDataState {
  final String message;

  const HomeDataError({required this.message});

  @override
  List<Object> get props => [message];
}
