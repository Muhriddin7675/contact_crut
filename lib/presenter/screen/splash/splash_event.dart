part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthEvent extends SplashEvent {}