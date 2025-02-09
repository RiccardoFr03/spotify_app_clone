part of 'dependency_injector.dart';

final List<RepositoryProvider> _repositories = [
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepository(),
  ),
  RepositoryProvider<SongRepository>(
    create: (context) => SongRepository(authRepository: context.read()),
  ),
  RepositoryProvider<ArtistRepository>(
    create: (context) => ArtistRepository(),
  ),
  RepositoryProvider<HistoryRepository>(
    create: (context) => HistoryRepository(
      songRepository: context.read(),
      authRepository: context.read(),
    ),
  ),
];
