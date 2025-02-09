import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/domain/models/artist_model.dart';
import 'package:spotify_clone/presetation/screens/artist_screen.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/image_widget.dart';

class Artists extends StatelessWidget {
  final List<ArtistModel> artists;
  final String title;
  final int maxItems;

  const Artists({
    super.key,
    required this.artists,
    this.title = 'Artisti del momento',
    this.maxItems = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: bold_20,
        ),
        height_4,
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          itemCount: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => _ArtistCard(artist: artists[index]),
        ),
      ],
    );
  }
}

class _ArtistCard extends StatelessWidget {
  final ArtistModel artist;

  const _ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('${ArtistiScreen.path}/${artist.name}');
      },
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: ImageWidget(
              artistName: artist.name,
              songTitle: null,
              height: 56,
              width: 56,
              fit: BoxFit.cover,
              borderOnlyLeft: true,
            ),
          ),
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey[900] : Color(0x140B1215),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                artist.name,
                style: semibold_14,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
