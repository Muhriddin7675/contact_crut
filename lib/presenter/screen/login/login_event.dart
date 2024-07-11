part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class SignIn extends LoginEvent {
  final String email;
  final String password;
  const SignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
