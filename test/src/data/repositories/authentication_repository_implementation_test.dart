import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practies/core/errors/exception.dart';
import 'package:practies/core/errors/failure.dart';
import 'package:practies/src/data/datasources/authentiction_remote_data_source.dart';
import 'package:practies/src/data/repositorie/authentication_repository_implementation.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSrc mockRemote;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    mockRemote = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(mockRemote);
  });

  const tException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );

  group('createUser', () {
    test(
      'should cal RemoteDataSource.createUser and return Right(null)',
      () async {
        // arrange
        when(
          () => mockRemote.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer((_) async => Future.value());

        const createdAt = 'whatever.createdAt';
        const name = 'whatever.name';
        const avatar = 'whatever.avatar';

        // act
        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        // assert
        expect(result, equals(const Right(null)));

        verify(
          () => mockRemote.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        ).called(1);

        verifyNoMoreInteractions(mockRemote);
      },
    );

    test(
      'should return a ServerFailure when the remote call throws APIException',
      () async {
        // arrange
        when(
          () => mockRemote.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow(tException);

        // act
        final result = await repoImpl.createUser(
          createdAt: 'created',
          name: 'test',
          avatar: 'img',
        );

        // assert
        expect(
          result,
          equals(
            Left<Failure, dynamic>(ServerFailure.fromException(tException)),
          ),
        );

        verify(
          () => mockRemote.createUser(
            createdAt: 'created',
            name: 'test',
            avatar: 'img',
          ),
        ).called(1);

        verifyNoMoreInteractions(mockRemote);
      },
    );
  });
}
