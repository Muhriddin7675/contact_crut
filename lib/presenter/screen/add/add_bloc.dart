import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contact_sqflite/data/model/contact_data.dart';
import 'package:flutter_contact_sqflite/data/model/contact_model.dart';
import 'package:flutter_contact_sqflite/domain/hive/my_hIve_helper.dart';
import 'package:flutter_contact_sqflite/domain/sqflite/my_database_contacts.dart';
import 'package:meta/meta.dart';


part 'add_event.dart';

part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddUser>((event, emit)  {
      // var contactRepository = RepositoryContact();
      // var contactRepository  = MyDatabaseContacts();

      // var boolean = await contactRepository.addContact(ContactData(name: event.name, phoneNumber: event.phone));

      var boolean = MyHiveHelper.addContact(ContactModel(event.name, event.phone));
      if (boolean) {
        print('Bloc.AddPopBackStack');
        emit(AddPopBackStack());
      } else {
        emit(AddErrorMessage());
      }
    });
  }
}
