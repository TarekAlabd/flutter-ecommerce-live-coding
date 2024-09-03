part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailed extends AuthState {
  final String error;

  AuthFailed(this.error);
}

final class AuthLoading extends AuthState {}

final class ToggleFormType extends AuthState {
  final AuthFormType authFormType;

  ToggleFormType(this.authFormType);
}
