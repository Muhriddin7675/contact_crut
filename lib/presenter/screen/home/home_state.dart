part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
 const HomeState();

 @override
 List<Object?> get props => [];
}


class ContactsLoaded extends HomeState {
 final List<ContactModel> contacts;

 const ContactsLoaded(this.contacts);

 @override
 List<Object?> get props => [contacts];
}

class ContactsLoading extends HomeState {}

class ContactsError extends HomeState{
 final String message;

  const ContactsError(this.message);

  @override
  List<Object?> get props => [message];
}
