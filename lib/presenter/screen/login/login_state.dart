part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class NavigateHome extends LoginState {}
final class ErrorMessage extends LoginState {}


