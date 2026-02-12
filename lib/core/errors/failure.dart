import 'package:equatable/equatable.dart';
import 'package:practies/core/errors/exception.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(APIException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}
