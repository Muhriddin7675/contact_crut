import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contact_sqflite/data/model/contact_model.dart';
import 'package:flutter_contact_sqflite/domain/hive/my_hIve_helper.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';

part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<UpdateContactData>((event, emit) {
      // var contactRepository = RepositoryContact();
      // var contactRepository = MyDatabaseContacts();
      // contactRepository.updateContact(ContactData(id: event.id, name: event.newName, phoneNumber: event.newPhone));
      MyHiveHelper.updateContact(event.contact);
      emit(PopBackStack());
    });
  }
}
