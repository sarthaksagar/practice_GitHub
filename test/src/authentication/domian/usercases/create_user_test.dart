import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practies/src/authentication1/domain1/repositories/authentication_repository.dart';
import 'package:practies/src/authentication1/domain1/usecases/create_user.dart';

// Mock Repository
class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUserUsecase usecase;
  late MockAuthRepo repository;  // Use Mock class as type

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUserUsecase(repository);
  });

  test('should call AuthRepo.createUser once', () async {
    const params = CreateUserParams(
      createdAt: 'createdAt',
      name: 'name',
      avatar: 'avatar',
    );

    when(() => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        )).thenAnswer((_) async => const Right(null));

    final result = await usecase(params);

  
    expect(result, const Right(null)); 

    verify(() => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        )).called(1);  
        verifyNoMoreInteractions(repository);
  });
}
