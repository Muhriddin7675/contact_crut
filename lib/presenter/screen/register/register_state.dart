part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterNavigateHome extends RegisterState {}
final class RegisterErrorMessage extends RegisterState {}
