import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:practies/core/utils/typedef.dart';
import 'package:practies/src/data/model/User_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test('empty constructor should return default values', () {
    final model = UserModel.empty();
    expect(model.id, 0);
    expect(model.avatar, '');
    expect(model.name, '');
    expect(model.createdAt, '');
  });

  final tJson = fixture('user.json');
  final DataMap tMap = jsonDecode(tJson) as DataMap;

    group('UserModel.fromMap', () {
    test('should return a valid UserModel from map', () {
      final result = UserModel.fromMap(tMap);

      expect(result.id, tMap['id']);
      expect(result.avatar, tMap['avatar']);
      expect(result.name, tMap['name']);
      expect(result.createdAt, tMap['createdAt']);
    });
  });

  group('UserModel.fromJson', () {
    test('should return a UserModel with the correct data', () {
      final result = UserModel.fromJson(tJson);
      expect(result.id, tMap['id']);
      expect(result.avatar, tMap['avatar']);
      expect(result.name, tMap['name']);
      expect(result.createdAt, tMap['createdAt']);
    });
  });
}
