import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/models/song_model.dart';
import 'package:spotify_clone/presetation/screens/song_player_screen.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/image_widget.dart';

class TakeBack extends StatelessWidget {
  final List<SongModel> songs;
  final String title;

  const TakeBack({
    super.key,
    required this.songs,
    this.title = 'Ultime Uscite',
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = _calculateItemWidth(screenWidth);
    final itemHeight = itemWidth;
    final listHeight = itemHeight + 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bold_20,
        ),
        height_4,
        SizedBox(
          height: listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) => _buildSongCard(
              context,
              songs[index],
              itemWidth,
              itemHeight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSongCard(
    BuildContext context,
    SongModel song,
    double width,
    double height,
  ) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => context.push(SongPlayerScreen.path, extra: song.songId),
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWidget(
                artistName: song.artist,
                songTitle: song.title,
                height: height,
                width: width,
                borderRadius: width * 0.15,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 4),
              Text(
                song.title,
                style: bold_20,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                song.artist,
                style: semibold_16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateItemWidth(double screenWidth) {
    if (screenWidth > 600) {
      return screenWidth * 0.25;
    } else {
      return screenWidth * 0.4;
    }
  }
}
