import 'package:practies/core/utils/typedef.dart';
import 'package:practies/src/authentication1/domain1/entites/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
