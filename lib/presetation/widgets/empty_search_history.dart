import 'package:flutter/material.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class EmptySearchHistory extends StatelessWidget {
  const EmptySearchHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 64,
              color: Colors.grey[600],
            ),
            height_8,
            Text(
              'Ascolta la tua musica preferita',
              style: semibold_24,
              textAlign: TextAlign.center,
            ),
            height_4,
            Text(
              'Cerca:',
              style: semibold_16,
              textAlign: TextAlign.center,
            ),
            height_4,
            Text(
              'Brani Artisti Podcast Playlist e molto altro',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
