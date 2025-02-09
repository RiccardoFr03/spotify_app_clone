import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/data/exeptions/firestore_failure.dart';
import 'package:spotify_clone/data/repositories/auth_repository.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/models/history_model.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

class HistoryRepository {
  final SongRepository songRepository;
  final AuthRepository authRepository;

  const HistoryRepository({required this.songRepository, required this.authRepository});

  Future<void> addSearch(String songId) async {
    try {
      final userId = authRepository.getUserId();
      final searchRef = FirebaseFirestore.instance.collection('searches').doc(userId).collection('searchHistory');

      final querySnapshot = await searchRef.where('songId', isEqualTo: songId).get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      final HistoryModel historyModel = HistoryModel(
        songId: songId,
        timestamp: DateTime.now(),
      );

      await searchRef.add(historyModel.toMap());
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        if (e is FirestoreFailure) {
          rethrow;
        } else {
          throw FirestoreFailure.fromCode(e.toString());
        }
      }
    }
  }

  Future<List<HistoryModel>> getUserSearchHistory() async {
    try {
      final userId = authRepository.getUserId();

      final searchRef = FirebaseFirestore.instance
          .collection('searches')
          .doc(userId)
          .collection('searchHistory')
          .orderBy('timestamp', descending: true);

      final querySnapshot = await searchRef.get();
      return querySnapshot.docs.map((doc) => HistoryModel.fromDocument(doc.data())).toList();
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }

  Future<void> deleteSearch(String searchId) async {
    try {
      final userId = authRepository.getUserId();

      final searchDocRef =
          FirebaseFirestore.instance.collection('searches').doc(userId).collection('searchHistory').doc(searchId);

      await searchDocRef.delete();
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }

  Future<List<SongModel>> getLastTenSearchedSongs() async {
    try {
      final userId = authRepository.getUserId();
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      final searchRef = firebaseFirestore
          .collection('searches')
          .doc(userId)
          .collection('searchHistory')
          .orderBy('timestamp', descending: true)
          .limit(10);

      final querySnapshot = await searchRef.get();

      final favoriteSnapshot = await firebaseFirestore.collection('Favorites').where('userId', isEqualTo: userId).get();
      final favoriteIds = favoriteSnapshot.docs.map((doc) => doc['songId'] as String).toSet();

      List<SongModel> songs = [];
      for (var doc in querySnapshot.docs) {
        String songId = doc['songId'] as String;
        String historyId = doc.id;

        final songDoc = await firebaseFirestore.collection('Songs').doc(songId).get();
        if (songDoc.exists) {
          SongModel songModel = SongModel.fromJson(songDoc.data()!);
          final isFavorite = favoriteIds.contains(songId);

          songModel = songModel.copyWith(
            isFavorite: isFavorite,
            songId: songId,
            historyId: historyId,
          );
          songs.add(songModel);
        }
      }
      return songs;
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }
}
