import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class HistoryModel extends Equatable {
  final String songId;
  final DateTime timestamp;
  final String? historyId;

  const HistoryModel({
    required this.songId,
    required this.timestamp,
    this.historyId,
  });

  factory HistoryModel.fromDocument(Map<String, dynamic> doc, {String? id}) {
    return HistoryModel(
      songId: doc['songId'] as String,
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
      historyId: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'timestamp': timestamp,
    };
  }

  HistoryModel copyWith({
    String? songId,
    DateTime? timestamp,
    String? historyId,
  }) {
    return HistoryModel(
      songId: songId ?? this.songId,
      timestamp: timestamp ?? this.timestamp,
      historyId: historyId ?? this.historyId,
    );
  }

  @override
  List<Object?> get props => [songId, timestamp, historyId];
}
