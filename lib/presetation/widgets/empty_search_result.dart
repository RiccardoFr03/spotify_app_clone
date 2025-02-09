import 'package:flutter/material.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class EmptySearchResult extends StatelessWidget {
  final String searchQuery;
  final String? customMessage;
  final IconData? customIcon;

  const EmptySearchResult({
    super.key,
    required this.searchQuery,
    this.customMessage,
    this.customIcon,
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
              customIcon ?? Icons.search_off_rounded,
              size: 64,
              color: Colors.grey[600],
            ),
            height_8,
            Text(
              customMessage ?? 'Nessun risultato trovato',
              style: semibold_24,
              textAlign: TextAlign.center,
            ),
            height_4,
            Text(
              'Nessuna corrispondenza trovata per "$searchQuery"',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            height_8,
            Text(
              'Prova a:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            height_4,
            Text(
              '• Controllare eventuali errori di digitazione\n• Usare parole chiave diverse\n• Utilizzare termini più generici',
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
