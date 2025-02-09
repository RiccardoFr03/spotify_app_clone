import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<Timestamp?, Object?> {
  const TimestampConverter();

  @override
  Timestamp? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json;
    if (json is Map<String, dynamic>) {
      return Timestamp(json['seconds'] as int, json['nanoseconds'] as int);
    }
    throw ArgumentError('Impossibile convertire il valore JSON in Timestamp: $json');
  }

  @override
  Object? toJson(Timestamp? object) {
    return object?.toDate().toIso8601String();
  }
}
