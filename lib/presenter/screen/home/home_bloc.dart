import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contact_sqflite/data/model/contact_model.dart';
import 'package:flutter_contact_sqflite/domain/hive/my_hIve_helper.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(ContactsLoading()) {
    // var repositoryContact = MyDatabaseContacts();
    var myHiveHelper = MyHiveHelper();

    on<DeleteContact>((event, emit) {
      print("delete contact ");
      MyHiveHelper.deleteContact(event.contact);
      // var a = await repositoryContact.deleteContact(event.id!);
    });

    on<InitContactList>((event, emit) {
      emit(ContactsLoading());
      try {
        // var contactList = await repositoryContact.getAllUser();
        var contactList = MyHiveHelper.getAllContact();
        ;
        print(contactList);
        emit(ContactsLoaded(contactList));
      } catch (e) {
        print(e.toString());
        emit(ContactsError(e.toString()));
      }
    });
  }
}
