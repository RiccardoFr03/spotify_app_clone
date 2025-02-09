import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_model.g.dart';

@CopyWith()
class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photo;
  final String? token;
  final String? refreshToken;

  const User({required this.id, this.email, this.name, this.photo, this.token, this.refreshToken});

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, name, photo, token, refreshToken];
}
