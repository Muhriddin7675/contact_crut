part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}
final class PopBackStack extends UpdateState {}
final class ErrorMessage extends UpdateState {}
