import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_sqflite/data/model/auth_model.dart';
import 'package:flutter_contact_sqflite/domain/hive/my_hIve_helper.dart';

import '../../../data/pref/my_shared.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    var myShared = MyShared();
    // var auth = Auth();
    // var auth = MyDatabaseAuth();
    on<SignIn>((event, emit) async {
      var boolean = MyHiveHelper.signIn(AuthModel(event.email, event.password));
      print("login $boolean");
      if (boolean) {
        myShared.setHasLogin(true);
        MyShared.setEmail(event.email);
        await MyHiveHelper.init();
        emit(NavigateHome());
      } else {
        emit(ErrorMessage());
      }

/*
     var bool =  auth.getUser(AuthData( null, email: event.email, password: event.password));
      if (bool) {
        myShared.setHasLogin(true);
        emit(NavigateHome());
      }
      else {
        emit(ErrorMessage());
    }*/
    });
  }
}
