import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_contact_sqflite/data/model/auth_model.dart';
import 'package:flutter_contact_sqflite/domain/hive/my_hIve_helper.dart';
import 'package:meta/meta.dart';

import '../../../data/pref/my_shared.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<Register>((event, emit) async {
      // var auth = Auth();
      // var auth = MyDatabaseAuth();
      // var myHiveHelper = MyHiveHelper();
      var myShared = MyShared();

      // var boolean = await auth.insertUser(AuthData( null, email: event.email, password: event.password));
      var boolean =
          MyHiveHelper.createUser(AuthModel(event.email, event.password));
      if (boolean) {
        myShared.setHasLogin(true);
        MyShared.setEmail(event.email);
        await MyHiveHelper.init();
        emit(RegisterNavigateHome());
      } else {
        emit(RegisterErrorMessage());
      }
    });
  }
}
