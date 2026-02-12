import 'package:practies/core/usecases/usecase.dart';
import 'package:practies/core/utils/typedef.dart';
import 'package:practies/src/authentication1/domain1/entites/user.dart';
import 'package:practies/src/authentication1/domain1/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async {
    return _repository.getUsers();
  }
}
