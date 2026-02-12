part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

final class UserCreated extends AuthenticationState {
  const UserCreated();
}

final class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

final class UsersLoaded extends AuthenticationState {
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
