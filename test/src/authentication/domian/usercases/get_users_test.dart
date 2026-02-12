import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practies/src/authentication1/domain1/entites/user.dart'
    as authUser;
import 'package:practies/src/authentication1/domain1/repositories/authentication_repository.dart';
import 'package:practies/src/authentication1/domain1/usecases/get_users.dart';

import 'create_user_test.dart'; // Contains MockAuthRepo

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  final tResponse = [authUser.User.empty()];

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  test('should call [AuthRepo.getUsers] and return [List<User>]', () async {
    when(
      () => repository.getUsers(),
    ).thenAnswer((_) async => Right(tResponse.cast<authUser.User>()));

    final result = await usecase();

    expect(result, equals(Right(tResponse)));

    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
