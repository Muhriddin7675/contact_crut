part of 'add_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}
final class AddPopBackStack extends AddState{}
final class AddErrorMessage extends AddState{}

