import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable()
@CopyWith()
class ArtistModel extends Equatable {
  final String? artistId;
  final String name;

  const ArtistModel({required this.artistId, required this.name});

  factory ArtistModel.fromJson(Map<String, dynamic> json) => _$ArtistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);

  @override
  List<Object?> get props => [artistId, name];
}
