// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SongModelCWProxy {
  SongModel title(String title);

  SongModel artist(String artist);

  SongModel duration(num duration);

  SongModel releaseDate(Timestamp? releaseDate);

  SongModel isFavorite(bool? isFavorite);

  SongModel songId(String? songId);

  SongModel historyId(String? historyId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SongModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SongModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SongModel call({
    String title,
    String artist,
    num duration,
    Timestamp? releaseDate,
    bool? isFavorite,
    String? songId,
    String? historyId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSongModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSongModel.copyWith.fieldName(...)`
class _$SongModelCWProxyImpl implements _$SongModelCWProxy {
  const _$SongModelCWProxyImpl(this._value);

  final SongModel _value;

  @override
  SongModel title(String title) => this(title: title);

  @override
  SongModel artist(String artist) => this(artist: artist);

  @override
  SongModel duration(num duration) => this(duration: duration);

  @override
  SongModel releaseDate(Timestamp? releaseDate) =>
      this(releaseDate: releaseDate);

  @override
  SongModel isFavorite(bool? isFavorite) => this(isFavorite: isFavorite);

  @override
  SongModel songId(String? songId) => this(songId: songId);

  @override
  SongModel historyId(String? historyId) => this(historyId: historyId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SongModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SongModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SongModel call({
    Object? title = const $CopyWithPlaceholder(),
    Object? artist = const $CopyWithPlaceholder(),
    Object? duration = const $CopyWithPlaceholder(),
    Object? releaseDate = const $CopyWithPlaceholder(),
    Object? isFavorite = const $CopyWithPlaceholder(),
    Object? songId = const $CopyWithPlaceholder(),
    Object? historyId = const $CopyWithPlaceholder(),
  }) {
    return SongModel(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      artist: artist == const $CopyWithPlaceholder()
          ? _value.artist
          // ignore: cast_nullable_to_non_nullable
          : artist as String,
      duration: duration == const $CopyWithPlaceholder()
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as num,
      releaseDate: releaseDate == const $CopyWithPlaceholder()
          ? _value.releaseDate
          // ignore: cast_nullable_to_non_nullable
          : releaseDate as Timestamp?,
      isFavorite: isFavorite == const $CopyWithPlaceholder()
          ? _value.isFavorite
          // ignore: cast_nullable_to_non_nullable
          : isFavorite as bool?,
      songId: songId == const $CopyWithPlaceholder()
          ? _value.songId
          // ignore: cast_nullable_to_non_nullable
          : songId as String?,
      historyId: historyId == const $CopyWithPlaceholder()
          ? _value.historyId
          // ignore: cast_nullable_to_non_nullable
          : historyId as String?,
    );
  }
}

extension $SongModelCopyWith on SongModel {
  /// Returns a callable class that can be used as follows: `instanceOfSongModel.copyWith(...)` or like so:`instanceOfSongModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SongModelCWProxy get copyWith => _$SongModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
      title: json['title'] as String,
      artist: json['artist'] as String,
      duration: json['duration'] as num,
      releaseDate: const TimestampConverter().fromJson(json['releaseDate']),
      isFavorite: json['isFavorite'] as bool?,
      songId: json['songId'] as String?,
      historyId: json['historyId'] as String?,
    );

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'title': instance.title,
      'artist': instance.artist,
      'duration': instance.duration,
      'releaseDate': const TimestampConverter().toJson(instance.releaseDate),
      'isFavorite': instance.isFavorite,
      'songId': instance.songId,
      'historyId': instance.historyId,
    };
