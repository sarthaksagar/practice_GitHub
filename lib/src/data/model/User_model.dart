import 'dart:convert';

import 'package:practies/core/utils/typedef.dart';
import 'package:practies/src/authentication1/domain1/entites/user.dart';

class UserModel extends User {
  const UserModel({
    required super.avatar,
    required super.id,
    required super.name,
    required super.createdAt,
  });

  factory UserModel.empty() {
    return const UserModel(id: 0, avatar: '', name: '', createdAt: '');
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      avatar: map['avatar'] as String,
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  UserModel copyWith({
    String? avatar,
    int? id,
    String? name,
    String? createdAt,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  DataMap toMap() => {
    'id': id,
    'avatar': avatar,
    'name': name,
    'createdAt': createdAt,
  };

  String toJson() => jsonEncode(toMap());
}
