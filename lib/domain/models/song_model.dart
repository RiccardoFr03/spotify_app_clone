import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spotify_clone/domain/helpers/time_helper.dart';

part 'song_model.g.dart';

@JsonSerializable()
@CopyWith()
class SongModel extends Equatable {
  final String title;
  final String artist;
  final num duration;
  @TimestampConverter()
  final Timestamp? releaseDate;
  final bool? isFavorite;
  final String? songId;
  final String? historyId;

  const SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
    required this.historyId,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => _$SongModelFromJson(json);

  Map<String, dynamic> toJson() => _$SongModelToJson(this);

  @override
  List<Object?> get props => [title, artist, duration, releaseDate, isFavorite, songId];
}
