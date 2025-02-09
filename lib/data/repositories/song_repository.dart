import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/data/exeptions/firestore_failure.dart';
import 'package:spotify_clone/data/repositories/auth_repository.dart';
import 'package:spotify_clone/domain/models/song_model.dart';

class SongRepository {
  final Map<String, bool> _favoriteCache = {};
  final AuthRepository authRepository;

  SongRepository({required this.authRepository});

  Future<List<SongModel>> _fetchSongs({required Query query}) async {
    try {
      final userId = authRepository.getUserId();

      final favoriteSnapshot =
          await FirebaseFirestore.instance.collection('Favorites').where('userId', isEqualTo: userId).get();

      final favoriteIds = favoriteSnapshot.docs.map((doc) => doc['songId'] as String).toSet();

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        final songModel = SongModel.fromJson(doc.data() as Map<String, dynamic>);
        final isFavorite = favoriteIds.contains(doc.id);
        return songModel.copyWith(isFavorite: isFavorite, songId: doc.id);
      }).toList();
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }

  Future<List<SongModel>> getSongsOrderedBy(String orderByField, {int? limit}) async {
    return _fetchSongs(
      query: FirebaseFirestore.instance.collection('Songs').orderBy(orderByField, descending: true).limit(limit ?? 50),
    );
  }

  Future<SongModel> getSongById(String id) async {
    final List<SongModel> songs = await _fetchSongs(
      query: FirebaseFirestore.instance.collection('Songs').where(FieldPath.documentId, isEqualTo: id),
    );
    final song = songs.first;
    return song;
  }

  Future<SongModel> getRandomSong() async {
    final List<SongModel> songs = await _fetchSongs(
      query: FirebaseFirestore.instance.collection('Songs'),
    );
    final int randomIndex = Random().nextInt(songs.length);
    return songs[randomIndex];
  }

  Future<List<SongModel>> getNewsSongs() => getSongsOrderedBy('releaseDate', limit: 5);

  Future<List<SongModel>> getRecentlyPlayed() => getSongsOrderedBy('releaseDate');

  Future<List<SongModel>> getArtistSongs(String name) async {
    return _fetchSongs(
      query: FirebaseFirestore.instance
          .collection('Songs')
          .where('artist', isGreaterThanOrEqualTo: name)
          .where('artist', isLessThan: '$name\uf8ff'),
    );
  }

  Future<bool> addOrRemoveFavoriteSong(String songId) async {
    try {
      final userId = authRepository.getUserId();
      final favoriteRef = FirebaseFirestore.instance.collection('Favorites');
      final querySnapshot =
          await favoriteRef.where('songId', isEqualTo: songId).where('userId', isEqualTo: userId).get();

      final isFavorite = querySnapshot.docs.isNotEmpty;

      if (isFavorite) {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.delete(querySnapshot.docs.first.reference);
        });
        _favoriteCache[songId] = false;
        return false;
      } else {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.set(favoriteRef.doc(), {'songId': songId, 'userId': userId});
        });
        _favoriteCache[songId] = true;
        return true;
      }
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }

  Future<bool> isFavoriteSong(String songId) async {
    if (_favoriteCache.containsKey(songId)) {
      return _favoriteCache[songId]!;
    }
    try {
      final userId = authRepository.getUserId();
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .where('userId', isEqualTo: userId)
          .get();

      final isFavorite = querySnapshot.docs.isNotEmpty;
      _favoriteCache[songId] = isFavorite;
      return isFavorite;
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }

  Future<List<SongModel>> getUserFavoriteSongs() async {
    try {
      final userId = authRepository.getUserId();
      final favoriteSnapshot =
          await FirebaseFirestore.instance.collection('Favorites').where('userId', isEqualTo: userId).get();

      final favoriteIds = favoriteSnapshot.docs.map((doc) => doc['songId'] as String).toList();

      final songs = await Future.wait(favoriteIds.map((songId) async {
        final songDoc = await FirebaseFirestore.instance.collection('Songs').doc(songId).get();

        if (songDoc.exists) {
          final songModel = SongModel.fromJson(songDoc.data()!);
          return songModel.copyWith(isFavorite: true, songId: songId);
        }
        return null;
      }));

      return songs.whereType<SongModel>().toList();
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }

  Future<List<SongModel>> searchSongs(String query) async {
    if (query.trim().isEmpty) return [];
    try {
      final lowercaseQuery = query.toLowerCase();

      final querySnapshot = await FirebaseFirestore.instance.collection('Songs').get();
      final userId = authRepository.getUserId();
      final favoriteSnapshot =
          await FirebaseFirestore.instance.collection('Favorites').where('userId', isEqualTo: userId).get();

      final favoriteIds = favoriteSnapshot.docs.map((doc) => doc['songId'] as String).toSet();

      final filteredSongs = querySnapshot.docs
          .map((doc) {
            final songModel = SongModel.fromJson(doc.data());
            final isFavorite = favoriteIds.contains(doc.id);

            if (songModel.title.toLowerCase().contains(lowercaseQuery) ||
                songModel.artist.toLowerCase().contains(lowercaseQuery)) {
              return songModel.copyWith(isFavorite: isFavorite, songId: doc.id);
            }
            return null;
          })
          .whereType<SongModel>()
          .toList();
      return filteredSongs.take(12).toList();
    } catch (e) {
      if (e is FirestoreFailure) {
        rethrow;
      } else {
        throw FirestoreFailure.fromCode(e.toString());
      }
    }
  }
}
