import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/data/exeptions/firestore_failure.dart';
import 'package:spotify_clone/domain/models/artist_model.dart';

class ArtistRepository {
  Future<List<ArtistModel>> getArtists({int limit = 6}) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('Artists').limit(limit).get();

      final artists = querySnapshot.docs.map((doc) {
        final artistModel = ArtistModel.fromJson(doc.data());
        return artistModel.copyWith(artistId: doc.id);
      }).toList();

      return artists;
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }
}
