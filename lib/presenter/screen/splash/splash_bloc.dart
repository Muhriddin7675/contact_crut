import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/pref/my_shared.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final MyShared myShared;

  SplashBloc(this.myShared) : super(SplashInitial()) {
    on<CheckAuthEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      final isLoggedIn = myShared.getHasLogin();
      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
