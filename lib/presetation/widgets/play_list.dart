import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/cubits/history/history_cubit.dart';
import 'package:spotify_clone/domain/models/song_model.dart';
import 'package:spotify_clone/presetation/screens/song_player_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/buttons/favorite_button.dart';
import 'package:spotify_clone/presetation/widgets/image_widget.dart';

class PlayList extends StatelessWidget {
  final List<SongModel> songs;
  final String title;
  final ScrollController? scrollController;
  final bool showFavorites;
  final bool? showMoreVert;
  final bool showDelete;
  final bool addToHistory;

  const PlayList({
    super.key,
    required this.songs,
    this.title = 'Playlist',
    this.scrollController,
    this.showFavorites = true,
    this.showMoreVert,
    this.showDelete = false,
    this.addToHistory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bold_20,
        ),
        height_4,
        ListView.builder(
          padding: EdgeInsets.all(0),
          controller: scrollController,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: songs.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _PlaylistItem(
              song: songs[index],
              showFavorite: showFavorites,
              showMoreVert: showMoreVert,
              showDelete: showDelete,
              onTap: () {
                HapticFeedback.lightImpact();
                if (addToHistory == true) {
                  context.read<HistoryCubit>().addSongToHistory(songs[index].songId ?? '');
                }
                context.push(SongPlayerScreen.path, extra: songs[index].songId);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaylistItem extends StatelessWidget {
  final SongModel song;
  final VoidCallback onTap;
  final bool showFavorite;
  final bool? showMoreVert;
  final bool showDelete;

  const _PlaylistItem({
    required this.song,
    required this.onTap,
    this.showFavorite = true,
    this.showMoreVert,
    required this.showDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ImageWidget(
                  artistName: song.artist,
                  songTitle: song.title,
                  height: 48,
                  width: 48,
                  borderRadius: 8,
                  fit: BoxFit.cover,
                ),
                width_8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: bold_16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        song.artist,
                        style: regular_12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showDelete) ...[
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {
                context.read<HistoryCubit>().removeSongToHistory(song.historyId ?? '');
              },
              icon: Icon(
                Icons.clear,
                size: 28,
                color: darkGrey,
              ),
            )
          ],
          if (showFavorite) ...[
            const SizedBox(width: 12),
            FavoriteButton(
              songEntity: song,
              updateData: true,
            )
          ],
          if (showMoreVert != null) ...[
            const SizedBox(width: 12),
            Icon(
              Icons.more_vert,
              size: 28,
              color: darkGrey,
            ),
          ],
        ],
      ),
    );
  }
}
