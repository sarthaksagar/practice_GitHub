import 'package:dartz/dartz.dart';
import 'package:practies/core/errors/exception.dart';
import 'package:practies/core/errors/failure.dart';
import 'package:practies/core/utils/typedef.dart';
import 'package:practies/src/authentication1/domain1/entites/user.dart';
import 'package:practies/src/authentication1/domain1/repositories/authentication_repository.dart';
import 'package:practies/src/data/datasources/authentiction_remote_data_source.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt, 
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUser();
      return Right(result.cast<User>());
    } on APIException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
