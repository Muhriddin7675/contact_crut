part of 'add_bloc.dart';

@immutable
sealed class AddEvent extends Equatable {
  const AddEvent();

  List<Object> get props => [];
}

class AddUser extends AddEvent {
  final String name;
  final String phone;

  const AddUser(this.name, this.phone);

  List<Object> get props => [];
}
