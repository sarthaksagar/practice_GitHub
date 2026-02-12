import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practies/core/errors/exception.dart';
import 'package:practies/core/utils/constants.dart';
import 'package:practies/src/data/model/user_model.dart';

const kCreateUserEndpoint = '/test-apil/users';
const kGetUserEndpoint = '/test-apil//user';

abstract class AuthenticationRemoteDataSource {
  get getUsers => null;

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUser();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kGetUserEndpoint));

      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<Map<String, dynamic>>.from(
        jsonDecode(response.body) as List,
      ).map((userData) => UserModel.fromMap(userData)).toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  // TODO: implement getUsers
  get getUsers => throw UnimplementedError();
}
