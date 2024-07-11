part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

class UpdateContactData extends UpdateEvent {
  final ContactModel contact;
  const UpdateContactData(this.contact);

  @override
  List<Object> get props => [];
}
