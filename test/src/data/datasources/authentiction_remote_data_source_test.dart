import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:practies/core/utils/constants.dart';
import 'package:practies/src/data/datasources/authentiction_remote_data_source.dart';
import 'package:practies/src/data/model/User_model.dart';
import 'package:practies/core/errors/exception.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
  });

  group('createUser', () {
    test(
      'should complete successfully when status code is 200 or 201',
      () async {
        when(
          () => client.post(
            any<Uri>(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        expect(
          () => remoteDataSource.createUser(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes,
        );

        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUsers', () {
    final tUsers = [UserModel.empty()];

    test('should return List<UserModel> when status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          jsonEncode([tUsers.first.toMap()]),
          200,
        ),
      );

      final result = await remoteDataSource.getUser();

      expect(result, equals(tUsers));

      verify(
        () => client.get(
          Uri.https(kBaseUrl, kGetUserEndpoint),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
      'should throw [APIException] when the status code is not 200',
      () async {
        const tMessage =
            'Server down, Server down. I repeat: Server down. Mayday Mayday.';

        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(tMessage, 500),
        );
  final methodCall =remoteDataSource.getUsers;
        expect(
          () => methodCall(),
          throwsA(isA<APIException>()),
        );

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kGetUserEndpoint),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
