part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/*class DeleteContact extends HomeEvent {
  final int? id;
  const DeleteContact(this.id);
}*/
class DeleteContact extends HomeEvent {
  final ContactModel contact;

  const DeleteContact(this.contact);
}

class InitContactList extends HomeEvent {}
