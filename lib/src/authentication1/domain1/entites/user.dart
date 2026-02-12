import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  const User.empty()
    : this(
        id: 0,
        name: '_empty.name',
        createdAt: '_empty.date',
        avatar: '_empty.avatar',
      );

  @override
  List<Object?> get props => [id, name, createdAt, avatar];
}
