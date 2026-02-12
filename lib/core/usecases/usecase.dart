import 'package:practies/core/utils/typedef.dart';

abstract class UsecaseWithParams<Types, Params> {
  const UsecaseWithParams();
  ResultFuture<Types> call(Params params);
}

abstract class UsecaseWithoutParams<Types> {
  ResultFuture<Types> call();
}
