part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  List<Object> get props => [];
}

class Register extends RegisterEvent {
  final String email;
  final String password;

  const Register(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
