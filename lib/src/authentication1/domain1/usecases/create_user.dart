import 'package:equatable/equatable.dart';
import 'package:practies/core/usecases/usecase.dart';
import 'package:practies/core/utils/typedef.dart';
import 'package:practies/src/authentication1/domain1/repositories/authentication_repository.dart';

class CreateUserUsecase extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUserUsecase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(createdAt: '_empty.string', name: '_empty.string', avatar: '_empty');

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
