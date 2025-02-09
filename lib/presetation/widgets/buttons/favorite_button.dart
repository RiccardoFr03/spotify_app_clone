import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/favorite/favorite_cubit.dart';
import 'package:spotify_clone/domain/cubits/home_data/home_data_cubit.dart';
import 'package:spotify_clone/domain/models/song_model.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';

class FavoriteButton extends StatelessWidget {
  final SongModel songEntity;
  final bool updateData;

  const FavoriteButton({
    required this.songEntity,
    this.updateData = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(songRepository: context.read()),
      child: BlocConsumer<FavoriteCubit, bool?>(
        listener: (context, state) {
          if (state != null && updateData) {
            context.read<HomeDataCubit>().updateFavoriteSong(songEntity.songId ?? '', state);
          } else {
            context.read<HomeDataCubit>().getHomeData();
          }
        },
        builder: (context, state) {
          final isFavorite = state ?? songEntity.isFavorite ?? false;

          return IconButton(
            onPressed: () async {
              await context.read<FavoriteCubit>().favoriteButtonUpdated(songEntity.songId ?? '');
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
              size: 28,
              color: isFavorite ? green : darkGrey,
            ),
          );
        },
      ),
    );
  }
}
