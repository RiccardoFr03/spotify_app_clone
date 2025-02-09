// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistModelCWProxy {
  ArtistModel artistId(String? artistId);

  ArtistModel name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistModel call({
    String? artistId,
    String name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistModel.copyWith.fieldName(...)`
class _$ArtistModelCWProxyImpl implements _$ArtistModelCWProxy {
  const _$ArtistModelCWProxyImpl(this._value);

  final ArtistModel _value;

  @override
  ArtistModel artistId(String? artistId) => this(artistId: artistId);

  @override
  ArtistModel name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistModel call({
    Object? artistId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return ArtistModel(
      artistId: artistId == const $CopyWithPlaceholder()
          ? _value.artistId
          // ignore: cast_nullable_to_non_nullable
          : artistId as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $ArtistModelCopyWith on ArtistModel {
  /// Returns a callable class that can be used as follows: `instanceOfArtistModel.copyWith(...)` or like so:`instanceOfArtistModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ArtistModelCWProxy get copyWith => _$ArtistModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) => ArtistModel(
      artistId: json['artistId'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'artistId': instance.artistId,
      'name': instance.name,
    };
